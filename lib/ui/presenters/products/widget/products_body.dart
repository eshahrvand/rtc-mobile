import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../router/app_route.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_product_item.dart';
import 'filter_bottom_sheet.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  void _showFilterSheet(
    BuildContext context,
    ProductChipModel chip,
    ProductState state,
  ) {
    if (chip.id == 1) {
      // Category Filter (Single-selection)
      FilterBottomSheet.show(
        context,
        title: chip.label,
        subtitle: '${chip.label} مورد نظر را انتخاب کنید',
        items: state.availableCategories
            .map((c) => FilterItem(id: c.id, title: c.name))
            .toList(),
        initialSelectedId: state.selectedCategoryId,
        onApply: (selected) {
          context.read<ProductCubit>().selectCategory(selected?.id);
        },
        onClear: () {
          context.read<ProductCubit>().selectCategory(null);
        },
      );
    } else if (chip.id == 2) {
      // Plan Filter
      FilterBottomSheet.show(
        context,
        title: chip.label,
        subtitle: '${chip.label} مورد نظر را انتخاب کنید',
        items: state.availableSubPlans
            .map((s) => FilterItem(id: s.id, title: s.name))
            .toList(),
        initialSelectedId: state.selectedSubPlanId,
        onApply: (selected) {
          context.read<ProductCubit>().selectSubPlan(selected?.id);
        },
        onClear: () {
          context.read<ProductCubit>().selectSubPlan(null);
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
              const SizedBox(height: 16),
              RtcChipList(
                chips: state.chips,
                isChipSelected: (index, chip) {
                  if (chip.id == 1) return state.selectedCategoryId != null;
                  if (chip.id == 2) return state.selectedSubPlanId != null;
                  if (chip.id == 3) return state.isOnlyAvailable;
                  return false;
                },
                onChipTap: (index, chip) => cubit.onChipTap(chip),
                onChipClose: (index, chip) => cubit.onChipClose(chip),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.status == ProductRequestStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: state.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.filteredProducts[index];
                          final hasPlan = state.selectedSubPlanId != null;
                          return RtcProductItem(
                            product: product,
                            showPrice: hasPlan,
                            onTap: () {
                              context.push(
                                AppRoutes.productDetail,
                                extra: {
                                  'productId': product.id,
                                  'subPlanId': state.selectedSubPlanId,
                                  'subPlanName': state.selectedSubPlanName,
                                  'showPrice': hasPlan,
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
