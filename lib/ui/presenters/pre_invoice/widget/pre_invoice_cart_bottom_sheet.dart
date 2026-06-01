import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../widget/rtc_discount_badge.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_counter.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceCartBottomSheet extends StatelessWidget {
  const PreInvoiceCartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Handle
                Container(
                  width: 32,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.brandPalette.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                _buildHeader(state.totalQuantity, context),
                const SizedBox(height: 14),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.cartItems.length,
                    separatorBuilder: (context, index) => RtcDivider(
                      color: AppColors.grayPalette.shade200,
                      height: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return _buildCartItem(item, cubit, context);
                    },
                  ),
                ),
                SizedBox(height: 10),
                RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
                const SizedBox(height: 10),
                _buildSummary(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(int count, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RtcImage(
              image: "$baseImage/cart_bottom_sheet.svg",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              S.current.cartTitle,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.grayPalette.shade20,
              ),
            ),
          ],
        ),

        Container(
          width: 42,
          height: 22,

          decoration: BoxDecoration(
            color: AppColors.successPalette.shade500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '$count ${S.current.productsFound.replaceAll('کالا پیدا شد', 'کالا')}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(
    CartItemModel item,
    PreInvoiceCubit cubit,
    BuildContext context,
  ) {
    return Column(
      spacing: 10,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayPalette.shade100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RtcImage(image: item.imageUrl, boxFit: BoxFit.contain),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (item.oldPrice != null)
                    Text(
                      item.oldPrice!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade700,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.price,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      const SizedBox(width: 2),
                      RtcImage(
                        image: "$baseImage/toman.svg",
                        width: 24,
                        height: 24,
                      ),
                      Spacer(),

                      if (item.discount != "0%")
                        RtcDiscountBadge(
                          discount: item.discount!,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerRight,
          child: RtcCounter(
            quantity: item.quantity,
            onAdd: () => cubit.increaseQuantity(item.productId),
            onRemove: () => cubit.removeFromCart(item.productId),
            isCardItem: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(PreInvoiceState state, BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        _buildSummaryRow(
          S.current.totalAmount,
          state.totalAmount,
          context: context,
        ),
        _buildSummaryRow(
          S.current.totalDiscounts,
          state.totalDiscounts,
          context: context,
        ),
        _buildSummaryRow(
          S.current.payableAmount,
          state.payableAmount,
          isBold: true,
          color: AppColors.brandPalette.shade600,
          context: context,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade700,
          ),
        ),

        Row(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color ?? AppColors.grayPalette.shade700,
                fontWeight: color != null ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            RtcImage(
              image: "$baseImage/toman.svg",
              width: 16,
              height: 16,
              color: color,
              boxFit: BoxFit.fill,
            ),
          ],
        ),
      ],
    );
  }
}
