import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

class RtcStepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStepIndex;
  final List<String> stepLabels;

  const RtcStepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStepIndex,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.primaryShadow,
      ),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 39,
            children: [
              Text(
                'مرحله ${currentStepIndex + 1} از $totalSteps',
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(totalSteps, (index) {
                    return index < totalSteps - 1
                        ? Expanded(
                            child: Row(
                              children: [_buildStepCircle(index), _buildStepLine()],
                            ),
                          )
                        : _buildStepCircle(index);
                  }).toList(),
                ),
              ),
            ],
          ),

          Text(
            stepLabels[currentStepIndex],
            style: theme.labelMedium!.copyWith(
              color: AppColors.brandPalette.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int index) {
    bool isCompleted = index < currentStepIndex;
    bool isActive = index == currentStepIndex;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.brandPalette.shade600
            : (isCompleted ? AppColors.brandPalette.shade600 : Colors.white),
        border: Border.all(
          color: isActive || isCompleted
              ? AppColors.brandPalette.shade600
              : AppColors.grayPalette.shade300,
          width: 2,
        ),
      ),
      child: Center(
        child: isActive
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              )
            : (isCompleted
                  ? RtcImage(
                      image: "$baseImage/check_badge.svg",
                      width: 16,
                      height: 16,
                      color: Colors.white,
                      boxFit: BoxFit.fill,
                    )
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grayPalette.shade300,
                      ),
                    )),
      ),
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(height: 0.5, color: AppColors.grayPalette.shade200),
    );
  }
}
