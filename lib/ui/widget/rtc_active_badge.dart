import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../theme/colors.dart';

class RtcActiveBadge extends StatelessWidget {
  const RtcActiveBadge({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: isActive
          ? AppColors.successPalette.shade50
          : AppColors.errorPalette.shade50,
    ),
    child: Text(
      isActive ? S.current.active : S.current.inactiveBranchStatus,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 12,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: isActive
            ? AppColors.successPalette.shade700
            : AppColors.errorPalette.shade700,
      ),
    ),
  );
}
