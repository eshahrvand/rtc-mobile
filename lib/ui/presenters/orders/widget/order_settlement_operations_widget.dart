import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'settlement_method_bottom_sheet.dart';

class OrderSettlementOperationsWidget extends StatelessWidget {
  final OrderOperationModel op;

  const OrderSettlementOperationsWidget({super.key, required this.op});

  void _showMethodSelector(BuildContext context, OrdersCubit cubit) {
    SettlementMethodBottomSheet.show(
      context,
      onSelect: (method) {
        cubit.initiateSettlement(method);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isPartial =
            state.clearanceStep != ClearanceStep.success &&
            state.clearanceAmount.isNotEmpty;
        final differenceAmount = state.excessAmount ?? '۰';

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.grayPalette.shade900,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '${op.step}',
                          style: theme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      op.title,
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    const Spacer(),
                    RtcImage(
                      image: "$baseImage/arrow_up_tab.svg",
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              if (isPartial)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  color: AppColors.warningPalette.shade50,
                  child: Text(
                    'در انتظار تکمیل عملیات تخلیه',
                    style: theme.bodySmall!.copyWith(
                      color: AppColors.warningPalette.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.settlementMethod,
                      style: theme.bodyMedium!.copyWith(
                        color: AppColors.grayPalette.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showMethodSelector(context, cubit),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.grayPalette.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _getMethodTitle(state.settlementMethod),
                              style: theme.bodyLarge!.copyWith(
                                color: AppColors.grayPalette.shade900,
                              ),
                            ),
                            const Spacer(),
                            RtcImage(
                              image: "$baseImage/angle-down_tab.svg",
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.differenceAmount,
                          style: theme.bodySmall!.copyWith(
                            color: AppColors.grayPalette.shade600,
                          ),
                        ),
                        Row(
                          spacing: 2,
                          children: [
                            Text(
                              differenceAmount,
                              style: theme.labelLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.warningPalette.shade600,
                              ),
                            ),
                            RtcImage(
                              image: "$baseImage/toman.svg",
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (state.settlementMethod == 'wallet')
                      Container(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                        decoration: BoxDecoration(
                          color: AppColors.successPalette.shade25,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.successPalette.shade100,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          spacing: 10,
                          children: [
                            RtcImage(
                              image: "$baseImage/tick_circle.svg",
                              width: 16,
                              height: 16,
                            ),
                            Expanded(
                              child: Text(
                                S.current.walletBalanceSufficient,
                                textAlign: TextAlign.right,
                                style: theme.bodyMedium!.copyWith(
                                  color: AppColors.successPalette.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Spacer(),
                        RtcButton(
                          title: _getButtonTitle(state.settlementMethod),
                          isActive:
                              !isPartial && state.settlementMethod != null,
                          styleBtn: theme.labelLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          width: 160,
                          onPressed: () => cubit.confirmSettlement(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMethodTitle(String? method) {
    switch (method) {
      case 'wallet':
        return S.current.walletSettlement;
      case 'ipg':
        return 'درگاه پرداخت آنلاین';
      case 'link':
        return 'تسویه نقدی (لینک پرداخت)';
      case 'offline':
        return 'ثبت فیش واریزی';
      default:
        return 'انتخاب روش تسویه';
    }
  }

  String _getButtonTitle(String? method) {
    switch (method) {
      case 'wallet':
        return S.current.payWithWallet;
      default:
        return 'تایید و پرداخت';
    }
  }
}
