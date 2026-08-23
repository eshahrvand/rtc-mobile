# Implementation Plan: Instance-Aware Navigation and Event Handling

Prevent duplicate `OrderDetailView` instances and "ghost" snackbars from background screens by introducing instance-level tracking.

## User Review Required

> [!IMPORTANT]
> This change introduces a `State`-based token in the `OrderDetailScreenTracker`. This ensures that even if multiple screens of the same order ID are on the stack (e.g. from an intended manual re-navigation), only the top-most, most recently mounted screen will react to broadcasted deep link events.

## Proposed Changes

### Core Utilities

#### [MODIFY] [order_detail_screen_tracker.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/core/utils/order_detail_screen_tracker.dart)
- Add a static `activeInstanceToken` field (of type `Object?`).
- This token will store the `hashCode` or reference of the top-most `_OrderDetailViewState`.

### Orders Component

#### [MODIFY] [orders_cubit.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/orders/bloc/orders_cubit.dart)
- In `fetchOrderDetail`, ensure `deepLinkPaymentOutcome` is reset to `initial` *immediately* at the start of the call if a new order is being fetched.
- Standardize the reset logic for `pendingNavigation`.

#### [MODIFY] [order_detail_view.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/orders/widget/order_detail_view.dart)
- **Lifecycle**: In `initState`, set `OrderDetailScreenTracker.activeInstanceToken = hashCode`.
- **Cleanup**: In `dispose`, if `activeInstanceToken == hashCode`, set it to `null`.
- **Listener Guard**: Update the `pendingNavigation` and `deepLinkPaymentOutcome` listeners to check `if (OrderDetailScreenTracker.activeInstanceToken != hashCode) return;`.

### Dashboard Component

#### [MODIFY] [dashboard.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/dashboard/dashboard.dart)
- Add a secondary navigation guard. Before calling `context.push`, check if the `orderId` matches the tracker.
- This acts as a synchronous lock to prevent "double-push" race conditions where the link arrives faster than the first screen can mount and register itself.

## Verification Plan

### Automated Tests
- N/A (UI lifecycle dependent).

### Manual Verification
1. **Success Flow Verification**:
   - Trigger success payment.
   - Verify success receipt shows.
   - Press back.
   - Verify you land on the **Orders list**, NOT another Order Detail screen.
2. **Failure Flow Regression**:
   - Trigger failure payment.
   - Verify failure snackbar shows.
   - Verify no duplicate screen is pushed underneath.
3. **Ghost Snackbar Check**:
   - Navigate: List -> Order X -> Pay -> Return.
   - Verify only ONE snackbar appears.
