import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';

class OrderOperationItemWidget extends StatelessWidget {
  final OrderOperationModel op;

  const OrderOperationItemWidget({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                op.title,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(width: 8),
              if (op.isCompleted) RtcStatusBadge(status: op.status),
              const Spacer(),
              if (!op.isCompleted)
                RtcImage(
                  image: "$baseImage/edit.svg",
                  width: 20,
                  height: 20,
                  color: AppColors.brandPalette.shade600,
                )
              else
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
              RtcImage(
                image: op.isCompleted
                    ? "$baseImage/angle-down_tab.svg"
                    : "$baseImage/arrow_up_tab.svg",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
        if (!op.isCompleted) ...[
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grayPalette.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'مبلغ تخلیه',
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.grayPalette.shade600,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '۱۲۴,۰۰۰,۰۰۰',
                            style: theme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brandPalette.shade600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.current.toman,
                            style: theme.bodySmall!.copyWith(
                              color: AppColors.brandPalette.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Text(
                  'در صورت تایید اطلاعات پس از زدن گزینه درخواست کد تخلیه، کد فرستاده شده به شماره مشتری را وارد و تایید کنید.',
                  textAlign: TextAlign.right,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                RtcButton(
                  title: 'درخواست کد تخلیه',
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  width: 180,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
