import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../generated/l10n.dart';
import 'bloc/product_detail_cubit.dart';
import 'bloc/product_detail_state.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_product_image_gallery.dart';
import '../../widget/rtc_product_badge_list.dart';
import '../../../../config/config.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit()..init(productId),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductDetailCubit, ProductDetailState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == ProductDetailRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  // TODO: replace with theme color
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: RtcAppBar(
          title: S.current.productDetail,
          onBack: () => context.pop(),
          backIconPath: "$baseImage/angle-right.svg",
        ),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
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
                  const SizedBox(height: 16),
                  RtcProductImageGallery(
                    imageUrls: product.imageUrls,
                    selectedIndex: state.selectedImageIndex,
                    onImageChanged: (index) => cubit.onImageSelected(index),
                  ),
                  const SizedBox(height: 26),
                  _PriceBlock(product: product),
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (product.discountPercent != null)
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.oldPrice != null)
                    Text(
                      product.oldPrice!,
                      style: theme.bodyLarge!.copyWith(
                        color: AppColors.grayPalette.shade500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                  if (product.oldPrice != null) SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.brandPalette.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        S.current.toman,
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.grayPalette.shade25,
                        ),
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
                'مشخصات فنی',
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
                  const Text(
                    '• ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Row(
                      spacing: 2,
                      children: [
                        Text(spec.key),
                        Text(
                          spec.value,
                          style: theme.bodyLarge!.copyWith(
                            color: AppColors.grayPalette.shade700,
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
                'توضیحات',
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

          Text(
            description,
            style: theme.bodyLarge!.copyWith(
              color: AppColors.grayPalette.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
