import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../router/app_route.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'rtc_order_item.dart';

class OrdersUiHelpers {
  /// Resolves the orders list body based on the current state.
  static Widget resolveOrdersListBody({
    required BuildContext context,
    required OrdersState state,
  }) {
    final theme = Theme.of(context).textTheme;

    return switch (state.status == OrdersRequestStatus.loading &&
        state.filteredOrders.isEmpty) {
      true => const Center(child: CircularProgressIndicator()),
      false => state.filteredOrders.isEmpty
          ? Center(
              child: Text(
                S.current.noItemsFound,
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
            )
          : ListView.builder(
              itemCount: state.filteredOrders.length,
              itemBuilder: (context, index) {
                final OrderSummaryModel order = state.filteredOrders[index];
                return RtcOrderItem(
                  order: order,
                  onTap: () {
                    context.push(AppRoutes.orderDetail, extra: order.id).then((_) {
                      if (context.mounted) {
                        context.read<OrdersCubit>().fetchOrders();
                      }
                    });
                  },
                );
              },
            ),
    };
  }

  /// Resolves the validity header for the order detail view.
  static Widget resolveValidityHeader(BuildContext context, dynamic order) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (order.remainingTime.isNotEmpty)
            Row(
              spacing: 4.0,
              children: [
                Text(
                  'زمان باقی‌مانده: ',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  order.remainingTime,
                  style: theme.bodySmall!.copyWith(
                    fontSize: 12.0,
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

  /// Resolves the settlement method title.
  static String resolveSettlementMethodTitle(String? method) {
    return switch (method) {
      'wallet_debit' => S.current.walletSettlement,
      'ipg' => 'پرداخت از طریق درگاه آنلاین',
      'link' => 'ارسال لینک پرداخت به مشتری',
      'card_to_card' => 'بارگذاری فیش واریزی',
      _ => 'انتخاب روش تسویه',
    };
  }

  /// Resolves the settlement action button title.
  static String resolveSettlementButtonTitle(String? method) {
    return switch (method) {
      'wallet_debit' => 'پرداخت با کیف پول',
      'ipg' => ' رفتن به درگاه شاپرک ',
      'link' => 'ارسال لینک پرداخت',
      'card_to_card' => 'بارگذاری فیش واریزی',
      _ => 'تایید و پرداخت',
    };
  }

  /// Resolves the settlement header trailing widget.
  static Widget resolveSettlementHeaderTrailing({
    required BuildContext context,
    required OrdersState state,
    required bool isExpanded,
  }) {
    final theme = Theme.of(context).textTheme;

    final lastStatus = state.lastSettlementStatusDisplay;

    if (state.isSettlementCompleted || lastStatus != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (lastStatus != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: RtcStatusBadge(status: lastStatus),
            ),
          Spacer(),
          RtcImage(
            image: ((state.isSettlementCompleted || lastStatus != null) &&
                    !isExpanded)
                ? "$baseImage/angle-down_tab.svg"
                : "$baseImage/arrow_up_tab.svg",
            width: 24.0,
            height: 24.0,
          ),
        ],
      );
    }

    if (state.isPartialClearance) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          height: 22.0,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: AppColors.warningPalette.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            spacing: 4.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              RtcImage(
                image: "$baseImage/waiting.svg",
                width: 12.0,
                height: 12.0,
                color: AppColors.grayPalette.shade900,
              ),
              Text(
                'در انتظار تکمیل تخلیه',
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.settlementMethod == 'link' &&
        state.settlementStep != SettlementStep.initial) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          children: [
            RtcImage(
              image: "assets/images/restart.svg",
              width: 20.0,
              height: 20.0,
            ),
            Text(
              'بروزرسانی',
              style: theme.bodyMedium!.copyWith(
                color: AppColors.brandPalette.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: RtcImage(
        image: (state.isSettlementCompleted && !isExpanded)
            ? "$baseImage/angle-down_tab.svg"
            : "$baseImage/arrow_up_tab.svg",
        width: 24.0,
        height: 24.0,
      ),
    );
  }
}
