import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_cubit.dart';
import 'bloc/product_state.dart';
import '../../widget/rtc_products_appbar.dart';
import '../../widget/rtc_chip_list.dart';
import '../../widget/rtc_product_item.dart';
import '../../widget/rtc_drawer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..init(),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocListener(
      listeners: [
        BlocListener<ProductCubit, ProductState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == ProductRequestStatus.error) {
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
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();

          return Scaffold(
            key: scaffoldKey,
            drawer: RtcDrawer(scaffoldKey: scaffoldKey),
            appBar: RtcProductsAppBar(
              isSearchActive: state.isSearchActive,
              searchQuery: state.searchQuery,
              scaffoldKey: scaffoldKey,
              cubit: cubit,
            ),
            body: Column(
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
                                // TODO: navigate to product details
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
