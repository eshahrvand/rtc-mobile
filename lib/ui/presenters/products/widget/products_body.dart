import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../router/app_route.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_product_item.dart';
import 'filter_bottom_sheet.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  void _showFilterSheet(BuildContext context, String title,
      List<FilterItem> items) {
    FilterBottomSheet.show(
      context,
      title: title,
      subtitle: '$title مورد نظر را انتخاب کنید',
      items: items,
      onApply: (selected) {
        if (selected != null) {
          context.read<ProductCubit>().selectFilter(selected.id);
        }
      },
      onClear: () => context.read<ProductCubit>().clearFilter(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (prev, curr) => prev.activeFilterChip != curr.activeFilterChip && curr.activeFilterChip != null,
      listener: (context, state) {
        final chip = state.activeFilterChip!;
        _showFilterSheet(
          context,
          chip.label,
          const [
            FilterItem(id: '1', title: 'گزینه آزمایشی ۱'),
            FilterItem(id: '2', title: 'گزینه آزمایشی ۲'),
          ],
        );
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
                selectedIndex: state.selectedChipIndex,
                onChipTap: (index, chip) => cubit.onChipTap(chip),
              ),
                const SizedBox(height: 16),
                Expanded(
                  child: state.status == ProductRequestStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    itemCount: state.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.filteredProducts[index];
                      return RtcProductItem(
                        product: product,
                        onTap: () {
                          context.push(
                            AppRoutes.productDetail,
                            extra: {'productId': product.id},
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
