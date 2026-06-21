import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../generated/l10n.dart';
import '../../widget/rtc_image.dart';
import 'bloc/product_detail_cubit.dart';
import 'bloc/product_detail_state.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_product_image_gallery.dart';
import '../../widget/rtc_product_badge_list.dart';
import '../../../../config/constants.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String? subPlanId;
  final String? subPlanName;
  final bool showPrice;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.subPlanId,
    this.subPlanName,
    this.showPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailCubit()
            ..init(productId, subPlanId: subPlanId, subPlanName: subPlanName),
      child: ProductDetailView(showPrice: showPrice),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  final bool showPrice;

  const ProductDetailView({super.key, required this.showPrice});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductDetailCubit, ProductDetailState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == ProductDetailRequestStatus.error) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: RtcAppBar(
          title: S.current.productDetail,
          onBack: () => context.pop(),
          backIconPath: "$baseImage/angle-right.svg",
        ),
        body: SafeArea(
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state.status == ProductDetailRequestStatus.loading ||
                  state.product == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final product = state.product!;
              final cubit = context.read<ProductDetailCubit>();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RtcProductImageGallery(
                      imageUrls: product.imageUrls,
                      selectedIndex: state.selectedImageIndex,
                      onImageChanged: (index) => cubit.onImageSelected(index),
                    ),
                    const SizedBox(height: 26),
                    if (showPrice) _PriceBlock(product: product),
                    if (!showPrice)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          product.name,
                          style: theme.titleSmall!.copyWith(
                            color: AppColors.grayPalette.shade20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    RtcProductBadgeList(badges: product.badges),
                    const SizedBox(height: 28),

                    _SpecsSection(specs: product.specs),

                    _DescriptionSection(description: product.description),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  final dynamic product;

  const _PriceBlock({required this.product});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: theme.titleSmall!.copyWith(
              color: AppColors.grayPalette.shade20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!product.isAvailable)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grayPalette.shade500,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'ناموجود',
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (product.isAvailable &&
                  product.discountPercent != null &&
                  product.discountPercent != '۰' &&
                  product.discountPercent != '0')
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.errorPalette.shade500,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    product.discountPercent!,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              const Spacer(),
              if (product.isAvailable)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.oldPrice != null &&
                        product.oldPrice!.isNotEmpty)
                      Text(
                        product.oldPrice!,
                        style: theme.bodyLarge!.copyWith(
                          color: AppColors.grayPalette.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (product.oldPrice != null &&
                        product.oldPrice!.isNotEmpty)
                      const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          product.price,
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.brandPalette.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        RtcImage(
                          image: "$baseImage/rial.svg",
                          width: 20,
                          height: 20,
                          boxFit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpecsSection extends StatelessWidget {
  final List<dynamic> specs;

  const _SpecsSection({required this.specs});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              Text(
                S.current.technicalSpecs,
                style: theme.labelLarge!.copyWith(
                  color: AppColors.grayPalette.shade20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: RtcDivider(color: AppColors.grayPalette.shade200),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...specs.map(
            (spec) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (spec.key.isNotEmpty && spec.key != 'مشخصات فنی')
                          Text(
                            '${spec.key}: ',
                            style: theme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        MarkdownBody(
                          data: spec.value,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(
                                Theme.of(context),
                              ).copyWith(
                                p: theme.bodyLarge!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String description;

  const _DescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              Text(
                S.current.description,
                style: theme.labelLarge!.copyWith(
                  color: AppColors.grayPalette.shade20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: RtcDivider(color: AppColors.grayPalette.shade200),
              ),
            ],
          ),

          MarkdownBody(
            data: description,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(
                  p: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade700,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
