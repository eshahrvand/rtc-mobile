import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_cart_widgets.dart';

class PreInvoiceCartBottomSheet extends StatelessWidget {
  const PreInvoiceCartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.padding.bottom;

    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Container(
          constraints: BoxConstraints(
            maxHeight: mediaQuery.size.height * 0.85,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, bottomInset > 0 ? 12 : 24),
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
                  PreInvoiceCartHeader(count: state.totalQuantity),
                  const SizedBox(height: 24),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.cartItems.length,
                      separatorBuilder: (context, index) => Column(
                        children: [
                          const SizedBox(height: 10),
                          RtcDivider(
                            color: AppColors.grayPalette.shade200,
                            height: 0.5,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return PreInvoiceCartItem(item: item, cubit: cubit);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
                  const SizedBox(height: 10),
                  PreInvoiceCartSummary(state: state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
