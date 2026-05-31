import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_clearance_receipt_sheet.dart';
import 'order_upload_documents_sheet.dart';
import 'order_tab_details.dart';
import 'order_tab_financial.dart';
import 'order_tab_history.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('${AppRoutes.dashboard}?index=2');
      },
      child: MultiBlocListener(
      listeners: [
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OrdersRequestStatus.error) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
          },
        ),
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) =>
              prev.uploadedClearanceDocPath != curr.uploadedClearanceDocPath,
          listener: (context, state) {
            if (state.uploadedClearanceDocPath != null &&
                state.clearanceStep == ClearanceStep.documentsPending) {
              _showUploadConfirmation(
                context,
                context.read<OrdersCubit>(),
                state.uploadedClearanceDocPath!,
              );
            }
          },
        ),
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.clearanceStep != curr.clearanceStep,
          listener: (context, state) {
            if (state.clearanceStep == ClearanceStep.success) {
              _showSuccessReceipt(context, state);
            }
          },
        ),
      ],
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.selectedOrder == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final order = state.selectedOrder!;
          final cubit = context.read<OrdersCubit>();

          return Scaffold(
            appBar: RtcAppBar(
              onBack: () => context.go('${AppRoutes.dashboard}?index=2'),
              backIconPath: '$baseImage/angle-right.svg',
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: RtcImage(
                    image: '$baseImage/print.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),

            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildValidityHeader(context, order),

                      RtcTabBar(
                        tabs: const ['جزییات سفارش', 'اطلاعات مالی', 'تاریخچه'],
                        selectedIndex: state.selectedTabIndex,
                        onTabChanged: (index) => cubit.onTabChanged(index),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: IndexedStack(
                    index: state.selectedTabIndex,
                    children: [
                      OrderTabDetails(order: order),
                      OrderTabFinancial(order: order),
                      OrderTabHistory(order: order),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
    );
  }

  void _showUploadConfirmation(
    BuildContext context,
    OrdersCubit cubit,
    String filePath,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OrderUploadDocumentsSheet(
        filePath: filePath,
        onConfirm: () {
          Navigator.pop(context);
          cubit.confirmClearanceDocument();
        },
      ),
    );
  }

  void _showSuccessReceipt(BuildContext context, OrdersState state) {
    OrderClearanceReceiptSheet.show(
      context,
      title: S.current.documentsSentSuccessTitle,
      subtitle: S.current.clearancePendingSubtitle,
      fields: [
        ReceiptField(
          label: S.current.proInvoiceNumberLabel,
          value: state.selectedOrder!.id.substring(0, 8).toUpperCase(),
        ),
        ReceiptField(
          label: S.current.customerLabelWithColon,
          value: state.selectedOrder!.customer.name,
        ),
        ReceiptField(
          label: S.current.clearanceAmountLabelWithColon,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.clearanceAmount,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              RtcImage(image: "$baseImage/toman.svg", width: 24, height: 24),
            ],
          ),
        ),
        ReceiptField(
          label: S.current.orderAmountLabel,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.selectedOrder!.financialSummary.finalAmount,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              RtcImage(image: "$baseImage/toman.svg", width: 24, height: 24),
            ],
          ),
        ),
        ReceiptField(label: S.current.gatewayLabel, value: 'تخلیه آفلاین'),
      ],
      onGotIt: () {
        context.read<OrdersCubit>().resetClearance();
      },
    );
  }

  Widget _buildValidityHeader(BuildContext context, dynamic order) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (order.remainingTime.isNotEmpty)
            Row(
              spacing: 4,
              children: [
                Text(
                  'زمان باقی‌مانده: ',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                  ),
                ),
                Text(
                  order.remainingTime,
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.errorPalette.shade500,
                  ),
                ),
              ],
            )
          else
            const SizedBox.shrink(),
          RtcStatusBadge(status: order.status, isPrimary: true),
        ],
      ),
    );
  }
}
