import 'package:axino/ui/presenters/widget/axino_image.dart';
import 'package:axino/ui/theme/colors.dart';
import 'package:axino/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RtcDetailBox extends StatelessWidget {
  const AxinoDetailBox({
    super.key,
    required this.tittle,
    required this.value,
    required this.isAmount,
    this.icon,
    this.width,
    this.isLoading = false,
    this.isHistory,
    this.isHistoryAmount,
  });

  final String tittle;
  final String value;
  final bool isAmount;
  final String? icon;
  final double? width;
  final bool isLoading;
  final bool? isHistory;
  final bool? isHistoryAmount;

  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: (isHistory ?? false)
            ? isDark
                ? AppColors.grayPalette.shade700
                : AppColors.white
            : (isHistoryAmount ?? false)
                ? isDark
                    ? AppColors.primaryLight
                    : AppColors.historyBackground
                : isAmount
                    ? isDark
                        ? AppColors.primaryLight
                        : AppColors.whiteBg
                    : isDark
                        ? AppColors.grayPalette.shade700
                        : AppColors.grayPalette.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Row(
          // spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon != null
                ? AxinoImage(image: icon)
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            SizedBox(
              width: 4,
            ),
            Text(
              tittle,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: (isDark && !isAmount)
                      ? AppColors.grayPalette.shade100
                      : (isDark && isAmount)
                          ? AppColors.grayPalette.shade800
                          : null),
            ),
            Expanded(child: SizedBox()),
            isLoading
                ? SizedBox(
                    height: 18,
                    width: 20,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [Colors.black],
                      strokeWidth: 4.0,
                    ),
                  )
                : Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: (isDark && !isAmount)
                            ? AppColors.grayPalette.shade100
                            : (isDark && isAmount)
                                ? AppColors.grayPalette.shade800
                                : AppColors.grayPalette.shade800),
                  ),
          ],
        ),
      ),
    );
  }
}
