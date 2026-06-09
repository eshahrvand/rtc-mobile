import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class OrderPaymentHistoryWidget extends StatelessWidget {
  final List<OrderPaymentModel> payments;

  const OrderPaymentHistoryWidget({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
          child: Text(
            'تاریخچه پرداخت‌ها',
            style: theme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ),
        ...payments.map(
          (p) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.grayPalette.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.type, style: theme.bodyMedium),
                    Text(
                      p.date,
                      style: theme.bodySmall!.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          p.amount,
                          style: theme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        RtcImage(
                          image: "$baseImage/toman.svg",
                          width: 24.0,
                          height: 24.0,
                        ),
                      ],
                    ),
                    if (p.status != null)
                      Text(
                        p.status!,
                        style: theme.labelSmall!.copyWith(
                          color: p.status == 'موفق'
                              ? AppColors.successPalette.shade600
                              : AppColors.errorPalette.shade600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
