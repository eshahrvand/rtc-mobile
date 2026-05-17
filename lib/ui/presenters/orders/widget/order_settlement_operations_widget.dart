import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';

class OrderSettlementOperationsWidget extends StatelessWidget {
  final OrderOperationModel op;

  const OrderSettlementOperationsWidget({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
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
              Container(
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
                      S.current.walletSettlement,
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
                    spacing: 4,
                    children: [
                      Text(
                        '۲۴,۰۰۰,۰۰۰',
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningPalette.shade600,
                        ),
                      ),
                      Text(
                        S.current.toman,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningPalette.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                  const SizedBox(width: 120),
                  const Spacer(),
                  RtcButton(
                    title: S.current.payWithWallet,
                    styleBtn: theme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    width: 160,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
