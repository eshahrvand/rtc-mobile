import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_active_badge.dart';
import '../../widget/rtc_image.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.active,
    required this.icon,
    required this.onTap,
  });
  final String title, subtitle, icon;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.grayPalette.shade200),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                RtcImage(
                  image: icon,
                  width: 20,
                  height: 20,
                  boxFit: BoxFit.contain,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.workspaceTextStrong,
                    ),
                  ),
                ),
                const RtcImage(
                  image: 'assets/images/workspace_angle_left.svg',
                  width: 20,
                  height: 20,
                  boxFit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(
              height: .5,
              thickness: .5,
              color: AppColors.grayPalette.shade100,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                  ),
                ),
                RtcActiveBadge(isActive: active),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
