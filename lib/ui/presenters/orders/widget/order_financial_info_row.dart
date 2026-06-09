import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class OrderFinancialInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const OrderFinancialInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          Row(
            spacing: 4.0,
            children: [
              Text(
                value,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                  fontSize: isBold ? 14.0 : 12.0,
                ),
              ),
              RtcImage(
                image: "$baseImage/toman.svg",
                width: 18.0,
                height: 18.0,
                boxFit: BoxFit.fill,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
