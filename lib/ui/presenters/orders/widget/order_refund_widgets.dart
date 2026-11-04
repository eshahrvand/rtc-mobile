import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_action_sheet.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';
import '../../workspace/bloc/workspace_cubit.dart';
import '../../workspace/bloc/workspace_state.dart';

// Keep refund UI hidden for both roles until the backend contract is available.
const bool _refundUiEnabled = false;

class OrderRefundAction extends StatelessWidget {
  const OrderRefundAction({super.key, required this.order});
  final OrderDetailModel order;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) {
          final eligible =
              order.orderStatus == OrderStatus.awaitingSettlement ||
              order.orderStatus == OrderStatus.underReview;
          if (!_refundUiEnabled ||
              !eligible ||
              order.refundRequested ||
              state.refundRequestedIds.contains(order.id)) {
            return const SizedBox.shrink();
          }
          return IconButton(
            tooltip: S.current.refundRequestTitle,
            onPressed: () => RtcActionSheet.show<void>(
              context,
              child: OrderRefundSheet(orderId: order.id),
            ),
            icon: const RtcImage(
              image: 'assets/images/workspace_arrow_forward_alt2.svg',
              width: 24,
              height: 24,
              boxFit: BoxFit.contain,
            ),
          );
        },
      );
}

class OrderRefundBadge extends StatelessWidget {
  const OrderRefundBadge({super.key, required this.order});
  final OrderDetailModel order;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) {
          if (!_refundUiEnabled ||
              (!order.refundRequested &&
                  !state.refundRequestedIds.contains(order.id))) {
            return const SizedBox.shrink();
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.purplePalette.shade500,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const RtcImage(
                  image: 'assets/images/waiting.svg',
                  boxFit: BoxFit.contain,
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  S.current.refundAwaitingReview,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class OrderStatusBadges extends StatelessWidget {
  const OrderStatusBadges({super.key, required this.order});
  final OrderDetailModel order;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) => Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            if (_refundUiEnabled &&
                (order.refundRequested ||
                    state.refundRequestedIds.contains(order.id)))
              OrderRefundBadge(order: order),
            RtcStatusBadge(status: order.status, isPrimary: true),
          ],
        ),
      );
}

class OrderRefundSheet extends StatelessWidget {
  const OrderRefundSheet({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<WorkspaceCubit, WorkspaceState>(
        listenWhen: (previous, current) =>
            !previous.refundRequestedIds.contains(orderId) &&
            current.refundRequestedIds.contains(orderId),
        listener: (context, state) => context.pop(),
        builder: (context, state) {
          final submitting = state.refundSubmittingIds.contains(orderId);
          return RtcActionSheet(
            title: S.current.refundRequestTitle,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.refundRequestMessage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 24 / 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.workspaceTextStrong,
                  ),
                ),
                if (state.errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage,
                    style: TextStyle(color: AppColors.errorPalette.shade600),
                  ),
                ],
              ],
            ),
            actions: Row(
              children: [
                Expanded(
                  child: RtcButton(
                    fitTitle: true,
                    title: S.current.cancelWorkspace,
                    isActive: !submitting,
                    onPressed: () => context.pop(),
                    backgroundColor: AppColors.grayPalette.shade50,
                    borderColor: AppColors.grayPalette.shade300,
                    styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.grayPalette.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RtcButton(
                    fitTitle: true,
                    title: S.current.confirmRefundRequest,
                    isLoading: submitting,
                    styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () =>
                        context.read<WorkspaceCubit>().requestRefund(orderId),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
