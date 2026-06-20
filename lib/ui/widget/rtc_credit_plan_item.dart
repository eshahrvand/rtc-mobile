import 'package:flutter/material.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../core/models/pre_invoice_model.dart';
import 'rtc_image.dart';

class RtcCreditPlanItem extends StatelessWidget {
  final CreditPlanItemModel plan;
  final bool isSelected;
  final VoidCallback onTap;

  const RtcCreditPlanItem({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme
        .of(context)
        .textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppColors.brandPalette.shade600
              : Colors.transparent,
          width: isSelected ? 2 : 0,
        ),
        boxShadow: AppColors.primaryShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.providerName,
                      style: theme.bodyMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plan.planName,
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ],
                ),
              ),

              RtcImage(
                image: plan.logo,
                width: 44,
                height: 44,
                boxFit: BoxFit.fill,
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.preInvoiceValidityDuration,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RtcDivider(
                  height: 0.5,
                  color: AppColors.grayPalette.shade200,
                ),
              ),
              SizedBox(width: 10),
              Text(
                plan.validityDuration,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              Text(
                S.current.day,
                style: theme.bodySmall!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    ),);
  }
}
