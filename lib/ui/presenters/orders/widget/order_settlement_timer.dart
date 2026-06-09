import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_state.dart';

class OrderSettlementTimer extends StatelessWidget {
  final OrdersState state;

  const OrderSettlementTimer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final minutes = (state.settlementCountdown / 60).floor();
    final seconds = state.settlementCountdown % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeStr,
          style: theme.labelLarge!.copyWith(
            color: AppColors.brandPalette.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8.0),
        RtcImage(
          image: "$baseImage/clock.svg",
          height: 20.0,
          width: 20.0,
          color: AppColors.brandPalette.shade600,
        ),
      ],
    );
  }
}
