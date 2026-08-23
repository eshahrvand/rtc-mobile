import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../generated/l10n.dart';
import '../../../router/app_route.dart';
import '../../../theme/colors.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_product_item.dart';
import 'filter_bottom_sheet.dart';
import '../../../../core/models/filter_item.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductCubit>().fetchNextPage();
    }
  }

  void _showFilterSheet(
    BuildContext context,
    ProductChipModel chip,
    ProductState state,
  ) {
    final cubit = context.read<ProductCubit>();
    if (chip.id == 1) {
      // Category Filter (Single-selection)
      FilterBottomSheet.show<ProductCubit, ProductState>(
        context,
        title: chip.label,
        subtitle: S.current.selectOptionSubtitle(chip.label),
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
          cubit.selectCategory(selected?.id);
        },
        onClear: () {
          cubit.selectCategory(null);
        },
      );
    } else if (chip.id == 4) {
      // Brand Filter (Single-selection)
      FilterBottomSheet.show<ProductCubit, ProductState>(
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
    } else if (chip.id == 2) {
      // Plan Filter
      FilterBottomSheet.show<ProductCubit, ProductState>(
        context,
        title: chip.label,
        subtitle: S.current.selectOptionSubtitle(chip.label),
        items: state.availableSubPlans
            .map((s) => FilterItem(id: s.id, title: s.name))
            .toList(),
        bloc: cubit,
        itemsSelector: (s) => s.availableSubPlans
            .map((s) => FilterItem(id: s.id, title: s.name))
            .toList(),
        loadingSelector: (s) => s.isSubPlanPaginationLoading,
        initialSelectedId: state.selectedSubPlanId,
        onLoadMore: () => cubit.fetchSubPlansNextPage(),
        onApply: (selected) {
          cubit.selectSubPlan(selected?.id);
        },
        onClear: () {
          cubit.selectSubPlan(null);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (prev, curr) =>
          prev.activeFilterChip != curr.activeFilterChip &&
          curr.activeFilterChip != null,
      listener: (context, state) {
        _showFilterSheet(context, state.activeFilterChip!, state);
        context.read<ProductCubit>().clearActiveFilterRequest();
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();

          return Column(
            children: [
              RtcChipList(
                chips: state.chips,
                isChipSelected: (index, chip) {
                  if (chip.id == 1) return state.selectedCategoryId != null;
                  if (chip.id == 4) return state.selectedBrandId != null;
                  if (chip.id == 2) return state.selectedSubPlanId != null;
                  if (chip.id == 3) return state.isOnlyAvailable;
                  return false;
                },
                onChipTap: (index, chip) => cubit.onChipTap(chip),
                onChipClose: (index, chip) => cubit.onChipClose(chip),
              ),
              Expanded(
                child: state.status == ProductRequestStatus.loading &&
                        state.allProducts.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : state.filteredProducts.isEmpty
                    ? Center(

                        child: Text(
                          S.current.noItemsFound,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.grayPalette.shade600),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: state.filteredProducts.length +
                            (state.isPaginationLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.filteredProducts.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final product = state.filteredProducts[index];
                          return RtcProductItem(
                            product: product,
                            showPrice: true,
                            onTap: () {
                              context.push(
                                AppRoutes.productDetail,
                                extra: {
                                  'productId': product.id,
                                  'subPlanId': state.selectedSubPlanId,
                                  'subPlanName': state.selectedSubPlanName,
                                  'showPrice': true,
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
