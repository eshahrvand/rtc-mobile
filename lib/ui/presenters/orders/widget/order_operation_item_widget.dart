import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';
import 'order_clearance_otp_sheet.dart';
import 'order_clearance_request_widget.dart';
import 'order_upload_documents_sheet.dart';

class OrderOperationItemWidget extends StatelessWidget {
  final OrderOperationModel op;

  const OrderOperationItemWidget({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade900,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${op.step}',
                    style: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                op.title,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(width: 8),
              if (op.isCompleted) RtcStatusBadge(status: op.status),
              const Spacer(),
              if (!op.isCompleted)
                RtcImage(
                  image: "$baseImage/edit.svg",
                  width: 20,
                  height: 20,
                  color: AppColors.brandPalette.shade600,
                )
              else
                RtcImage(
                  image: "$baseImage/angle-down_tab.svg",
                  width: 24,
                  height: 24,
                ),
            ],
          ),
        ),
        if (!op.isCompleted)
          OrderClearanceRequestWidget(
            amount: '۱۲۴,۰۰۰,۰۰۰',
            onRequestCode: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => OrderUploadDocumentsSheet(
                  onConfirm: () {
                    Navigator.pop(context);
                    // Handle confirmation
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
