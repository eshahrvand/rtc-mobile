import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مرحله ${currentStepIndex + 1} از $totalSteps',
                style: const TextStyle(
                  // TODO: replace with theme values
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: List.generate(totalSteps, (index) {
                  return Row(
                    children: [
                      _buildStepCircle(index),
                      if (index < totalSteps - 1) _buildStepLine(index),
                    ],
                  );
                }).reversed.toList(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stepLabels[currentStepIndex],
            style: const TextStyle(
              // TODO: replace with theme values
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
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
        color: isActive ? Colors.blue : (isCompleted ? Colors.blue : Colors.white),
        border: Border.all(
          color: isActive || isCompleted ? Colors.blue : Colors.grey.shade300,
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
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                  )),
      ),
    );
  }

  Widget _buildStepLine(int index) {
    bool isCompleted = index < currentStepIndex;
    return Container(
      width: 30,
      height: 2,
      color: isCompleted ? Colors.blue : Colors.grey.shade300,
    );
  }
}
