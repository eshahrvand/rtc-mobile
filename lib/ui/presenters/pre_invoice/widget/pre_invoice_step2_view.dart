import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/pre_invoice_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'rtc_pre_invoice_product_item.dart';

class PreInvoiceStep2View extends StatelessWidget {
  const PreInvoiceStep2View({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: RtcTextField(
                      hintText: S.current.searchHint,
                      hintStyle: theme.bodyLarge!.copyWith(
                        color: AppColors.grayPalette.shade400,
                      ),
                      onChanged: (value) => cubit.onSearchChanged(value),
                      prefix: RtcImage(image: "$baseImage/search.svg"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.grayPalette.shade25,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grayPalette.shade200),
                    ),
                    child: RtcImage(image: "$baseImage/sort.svg"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 48,
                    width: 140,
                    child: RtcChipList(
                      chips: state.filterChips
                          .where((c) => c.label == "دسته بندی")
                          .map(
                            (c) => ProductChipModel(
                              id: c.id,
                              label: c.label,
                              opensBottomSheet: c.opensBottomSheet,
                            ),
                          )
                          .toList(),
                      selectedIndex: -1,
                      onChipTap: (index, chip) => cubit.onChipSelected(index),
                    ),
                  ),
                  const Spacer(),

                  GestureDetector(
                    onTap: () => cubit.toggleShowAvailableOnly(),
                    child: RtcImage(
                      image: state.showAvailableOnly
                          ? "$baseImage/toggle_base.svg"
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
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
              child: ListView.builder(
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
            _buildBottomBar(context, state, cubit),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    PreInvoiceState state,
    PreInvoiceCubit cubit,
  ) {
    int totalItems = state.cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => cubit.showCart(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.blue,
                  ),
                ),
                if (totalItems > 0)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$totalItems',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RtcButton(
              title: totalItems > 0
                  ? '${S.current.nextStep} ($totalItems ${S.current.products})'
                  : S.current.nextStep,
              isActive: totalItems > 0,
              onPressed: () => cubit.goToStep(PreInvoiceStep.customerInfo),
            ),
          ),
        ],
      ),
    );
  }
}
