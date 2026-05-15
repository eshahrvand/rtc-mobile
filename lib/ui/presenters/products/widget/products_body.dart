import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../router/app_route.dart';
import '../bloc/product_cubit.dart';
import '../bloc/product_state.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_product_item.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
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
            const SizedBox(height: 8),
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
    );
  }
}
