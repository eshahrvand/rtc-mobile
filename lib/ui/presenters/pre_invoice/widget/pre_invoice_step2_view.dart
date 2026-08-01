import 'package:rtc_mobile/ui/presenters/pre_invoice/widget/pre_invoice_step2_widgets.dart';

import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../core/models/filter_item.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../../../../core/models/product_chip_model.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<PreInvoiceCubit>().fetchProductsNextPage();
    }
  }

  void _showCategoryFilter(
    BuildContext context,
    PreInvoiceCubit cubit,
    PreInvoiceState state,
  ) {
    FilterBottomSheet.show<PreInvoiceCubit, PreInvoiceState>(
      context,
      title: S.current.categoryTitle,
      subtitle: S.current.categoryFilterSubtitle,
      items: state.availableCategories
          .map((c) => FilterItem(id: c.id, title: c.name))
          .toList(),
      bloc: cubit,
      itemsSelector: (s) => s.availableCategories
          .map((c) => FilterItem(id: c.id, title: c.name))
          .toList(),
      loadingSelector: (s) => s.isCategoryPaginationLoading,
      initialSelectedId: state.selectedCategoryId,
      onLoadMore: () => cubit.fetchCategoriesNextPage(),
      onApply: (selected) {
        cubit.onCategorySelected(selected?.id);
      },
      onClear: () {
        cubit.onCategorySelected(null);
      },
    );
  }

  void _showSortFilter(
    BuildContext context,
    PreInvoiceCubit cubit,
    PreInvoiceState state,
  ) {
    final items = [
      FilterItem(id: 'plan_price', title: S.current.cheapest),
      FilterItem(id: '-plan_price', title: S.current.mostExpensive),
      FilterItem(id: 'created_at', title: S.current.newest),
      FilterItem(id: '-created_at', title: S.current.oldest),
    ];

    FilterBottomSheet.show(
      context,
      title: S.current.sortTitle,
      subtitle: S.current.sortSubtitle,
      items: items,
      iconPath: '$baseImage/sort.svg',
      clearButtonTitle: 'حذف',
      initialSelectedId: state.selectedSortOrder,
      onApply: (selected) {
        cubit.onSortSelected(selected?.id);
      },
      onClear: () {
        cubit.onSortSelected(null);
      },
    );
  }

  void _showBrandFilter(
    BuildContext context,
    PreInvoiceCubit cubit,
    PreInvoiceState state,
  ) {
    FilterBottomSheet.show<PreInvoiceCubit, PreInvoiceState>(
      context,
      title: S.current.brand,
      subtitle: S.current.brandFilter,
      items: state.availableBrands
          .map((b) => FilterItem(id: b.id, title: b.name))
          .toList(),
      bloc: cubit,
      itemsSelector: (s) => s.availableBrands
          .map((b) => FilterItem(id: b.id, title: b.name))
          .toList(),
      loadingSelector: (s) => s.isBrandPaginationLoading,
      initialSelectedId: state.selectedBrandId,
      onLoadMore: () => cubit.fetchBrandsNextPage(),
      onApply: (selected) {
        cubit.selectBrand(selected?.id);
      },
      onClear: () {
        cubit.selectBrand(null);
      },
    );
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
                    GestureDetector(
                      onTap: () => _showSortFilter(context, cubit, state),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: state.selectedSortOrder != null
                              ? AppColors.brandPalette.shade50
                              : AppColors.grayPalette.shade25,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: state.selectedSortOrder != null
                                ? AppColors.brandPalette.shade200
                                : AppColors.grayPalette.shade200,
                          ),
                        ),
                        child: RtcImage(
                          image: "$baseImage/sort.svg",
                          color: state.selectedSortOrder != null
                              ? AppColors.brandPalette.shade600
                              : AppColors.grayPalette.shade700,
                        ),
                      ),
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
                      width: 200,
                      child: RtcChipList(
                        chips: [
                          ProductChipModel(
                            id: 1,
                            label: S.current.category,
                            opensBottomSheet: true,
                          ),
                          ProductChipModel(
                            id: 4,
                            label: S.current.brand,
                            opensBottomSheet: true,
                          ),
                        ],
                        isChipSelected: (index, chip) {
                          if (chip.id == 1)
                            return state.selectedCategoryId != null;
                          if (chip.id == 4)
                            return state.selectedBrandId != null;
                          return false;
                        },
                        onChipTap: (index, chip) {
                          if (chip.id == 1) {
                            _showCategoryFilter(context, cubit, state);
                          } else if (chip.id == 4) {
                            _showBrandFilter(context, cubit, state);
                          }
                        },
                        onChipClose: (index, chip) {
                          if (chip.id == 1) {
                            cubit.onCategorySelected(null);
                          } else if (chip.id == 4) {
                            cubit.selectBrand(null);
                          }
                        },
                      ),
                    ),
                    const Spacer(),

                    PreInvoiceStep2AvailabilityToggle(
                      showAvailableOnly: state.showAvailableOnly,
                      onToggle: () => cubit.toggleShowAvailableOnly(),
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
                  state.totalProductCount == 0
                      ? SizedBox.shrink()
                      : Text(
                          '${state.totalProductCount} ${S.current.productsFound}',
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
                      controller: _scrollController,
                      itemCount:
                          state.filteredProducts.length +
                          (state.isProductPaginationLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.filteredProducts.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

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
