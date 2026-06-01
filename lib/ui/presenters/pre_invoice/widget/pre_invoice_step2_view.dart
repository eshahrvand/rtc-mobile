import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/pre_invoice_model.dart';
import '../../../../locator.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_text_field.dart';
import '../../products/widget/filter_bottom_sheet.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'rtc_pre_invoice_product_item.dart';

class PreInvoiceStep2View extends StatefulWidget {
  const PreInvoiceStep2View({super.key});

  @override
  State<PreInvoiceStep2View> createState() => _PreInvoiceStep2ViewState();
}

class _PreInvoiceStep2ViewState extends State<PreInvoiceStep2View> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCategoryFilter(
    BuildContext context,
    PreInvoiceCubit cubit,
    PreInvoiceState state,
  ) {
    sl<ProductRepository>().getCategories().then((response) {
      final items = response.results
          .map((c) => FilterItem(id: c.id, title: c.name))
          .toList();

      if (context.mounted) {
        FilterBottomSheet.show(
          context,
          title: S.current.categoryTitle,
          subtitle: S.current.categoryFilterSubtitle,
          items: items,
          initialSelectedId: state.selectedCategoryId,
          onApply: (selected) {
            cubit.onCategorySelected(selected?.id);
          },
          onClear: () {
            cubit.onCategorySelected(null);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: RtcTextField(
                        controller: _searchController,
                        hintText: S.current.searchHint,
                        hintStyle: theme.bodyLarge!.copyWith(
                          color: AppColors.grayPalette.shade400,
                        ),
                        onChanged: (value) {
                          cubit.onSearchChanged(value);
                          setState(() {});
                        },
                        prefix: RtcImage(
                          image: "$baseImage/search.svg",
                          boxFit: BoxFit.contain,
                          width: 20,
                          height: 20,
                        ),
                        suffix: _searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  cubit.onSearchChanged('');
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: RtcImage(
                                    image: "$baseImage/close.svg",
                                    width: 20,
                                    height: 20,
                                    boxFit: BoxFit.fill,
                                    color: AppColors.grayPalette.shade700,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.grayPalette.shade25,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.grayPalette.shade200,
                        ),
                      ),
                      child: RtcImage(image: "$baseImage/sort.svg"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 140,
                      child: RtcChipList(
                        chips: [
                          ProductChipModel(
                            id: 1,
                            label: 'دسته بندی',
                            opensBottomSheet: true,
                          ),
                        ],
                        isChipSelected: (index, chip) =>
                            state.selectedCategoryId != null,
                        onChipTap: (index, chip) =>
                            _showCategoryFilter(context, cubit, state),
                      ),
                    ),
                    const Spacer(),

                    GestureDetector(
                      onTap: () => cubit.toggleShowAvailableOnly(),
                      child: RtcImage(
                        image: state.showAvailableOnly
                            ? "$baseImage/toggle_active.svg"
                            : "$baseImage/toggle_base.svg",
                        width: 36,
                        height: 20,
                      ),
                    ),

                    const SizedBox(width: 8),
                    Text(
                      "نمایش کالاهای موجود",
                      style: theme.bodyMedium!.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  state.filteredProducts.isEmpty
                      ? SizedBox.shrink()
                      : Text(
                          '${state.filteredProducts.length} ${S.current.productsFound}',
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade900,
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              child: state.status == PreInvoiceRequestStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state.filteredProducts.isEmpty
                  ? Center(
                      child: Text(
                        S.current.noItemsFound,
                        style: theme.bodyLarge?.copyWith(
                          color: AppColors.grayPalette.shade600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.filteredProducts[index];
                        final cartItem = state.cartItems.firstWhere(
                          (item) => item.productId == product.id,
                          orElse: () => CartItemModel(
                            productId: '',
                            name: '',
                            imageUrl: '',
                            price: '',
                            quantity: 0,
                          ),
                        );

                        return RtcPreInvoiceProductItem(
                          product: product,
                          quantity: cartItem.quantity,
                          onAdd: () => cubit.addToCart(product),
                          onRemove: () => cubit.removeFromCart(product.id),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
