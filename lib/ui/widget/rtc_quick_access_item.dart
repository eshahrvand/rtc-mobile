import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

class RtcQuickAccessItem extends StatelessWidget {
  final String title;
  final String value;
  final String currency;
  final String iconPath;
  final String? percentage;
  final VoidCallback onTap;

  const RtcQuickAccessItem({
    super.key,
    required this.title,
    required this.value,
    required this.currency,
    required this.iconPath,
    this.percentage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: AppColors.primaryShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  percentage != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.successPalette.shade50,

                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                            child: Row(
                              spacing: 4,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  percentage!,
                                  style: theme.bodySmall!.copyWith(
                                    color: AppColors.successPalette.shade600,
                                  ),
                                ),

                                RtcImage(
                                  image: "$baseImage/arrow-up.svg",
                                  width: 10,
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),

                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.brandPalette.shade50,

                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: RtcImage(image: iconPath, width: 20, height: 20),
                    ),
                  ),
                ],
              ),

              Text(
                title,
                textAlign: TextAlign.right,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: theme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),

                  Text(
                    currency,
                    style: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
