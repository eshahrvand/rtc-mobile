# Order Status Investigation (Step 1)

## Received from Server
- `dto.status` in `lib/repository/orders/orders_repository.dart` (raw English strings like `pre_invoice`).
- `s.status` in `DashboardCubit._mapOrderStatusChart` (`OrderStatusDtoModel`).

## Mapped/Stored
- `lib/repository/orders/orders_repository.dart` uses `_mapStatus` to convert English to Persian before storing in models.
- `OrderSummaryModel.status` and `OrderDetailModel.status` in `lib/data/models/order_model.dart` currently store Persian strings.

## Compared

### Against Persian Strings
- `lib/ui/widget/rtc_status_badge.dart`:
  - `status == 'پیش فاکتور'`
  - `status == 'در انتظار تسویه'`
  - `status == 'در انتظار تایید'`
  - `status == 'تایید شده'`
  - `status == 'رد شده'`
  - `status == 'منقضی شده'`
  - `status == 'انجام شده'` (Note: might be specific to operations)
- `lib/ui/presenters/orders/widget/order_tab_financial.dart`:
  - `widget.order.status == 'پیش فاکتور'`
  - `widget.order.status == 'در انتظار تسویه'`
  - `widget.order.status == 'در انتظار تایید'`
  - `widget.order.status == 'تایید شده'`
  - `widget.order.status == 'رد شده'`
- `lib/ui/presenters/orders/bloc/orders_cubit.dart`:
  - `detail.status == 'پیش فاکتور'`
  - `detail.status == 'در انتظار تسویه'`
  - `detail.status == 'تایید شده'`
  - `detail.status == 'در انتظار تایید'`
  - `detail.status == 'رد شده'`
  - List of statuses in `_createDisburseOp` and `_createSettlementOp`.

### Against English Strings
- `lib/ui/presenters/dashboard/bloc/dashboard_cubit.dart`:
  - `s.status == 'approved'`
  - `s.status == 'reject'`
  - `s.status == 'rejected'`
  - `s.status == 'under_review'`
  - `s.status == 'pre_invoice'`
  - `s.status == 'expired'`
  - `s.status == 'awaiting_settlement'`
- `lib/repository/orders/orders_repository.dart`:
  - `dto.status == 'approved'`
  - `dto.status == 'rejected'`

## Displayed (Direct usage of `.status`)
- `lib/ui/widget/rtc_status_badge.dart`: `Text(status)`
- `lib/ui/presenters/orders/widget/order_detail_view.dart`: `RtcStatusBadge(status: order.status)`
- `lib/ui/presenters/orders/widget/rtc_order_item.dart`: `RtcStatusBadge(status: order.status)`
- `lib/ui/widget/rtc_dashboard_order_item.dart`: `RtcStatusBadge(status: order.status)`
- `lib/ui/widget/rtc_customer_order_item.dart`: `RtcStatusBadge(status: order.status)`
- `lib/ui/presenters/dashboard/bloc/dashboard_cubit.dart`: `label = s.status` (fallback).
