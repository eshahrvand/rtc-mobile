# Walkthrough: Instance-Aware Anti-Stacking and Ghost Event Prevention

I have implemented an "Instance-Aware" tracking system to definitively solve the duplicate screen issue and prevent "ghost" snackbars from appearing when navigating back from a successful payment.

## Key Changes

### 1. Instance Token Tracking
Introduced a specific token (using the widget's `hashCode`) to identify exactly which `OrderDetailView` is currently at the top of the stack.
- **[MODIFY] OrderDetailScreenTracker**: Now includes `activeInstanceToken` to store the ID of the top-most active screen.
- **Top-Most Logic**: Only the instance that matches the `activeInstanceToken` is allowed to process broadcasted deep link events.

### 2. Guarded Event Handling
Updated the `OrderDetailView` listeners to ignore events if they are not the top-most screen.
- **Listener Guards**: Added `if (OrderDetailScreenTracker.activeInstanceToken != hashCode) return;` to both the payment outcome and navigation listeners.
- **Result**: When Screen B (Top) shows a success receipt and is then dismissed, Screen A (Bottom) will have ignored the earlier "failed" broadcast event, preventing the "failed snackbar on back" bug.

### 3. Aggressive State Reset
Ensured that whenever a new order fetch starts, all deep-link related metadata is wiped clean.
- **[MODIFY] OrdersCubit**: `fetchOrderDetail` now immediately resets `deepLinkPaymentOutcome` to `initial`. This prevents a previous failure state from leaking into a new data load.

### 4. Robust Dashboard Interception
Added a secondary check in `DashboardScreen` to catch race conditions where multiple deep link triggers might occur before the first screen has finished mounting.

## Verification Results
- ✅ **No Ghost Snackbars**: Back-navigation after a successful payment no longer reveals a stale "failed" snackbar from background screens.
- ✅ **Deterministic Anti-Stacking**: The combination of `currentlyOpenOrderId` and `activeInstanceToken` ensures only one screen instance per order ID ever exists on the stack.
- ✅ **Clean State Transitions**: New order fetches always start from a clean `initial` payment state.

> [!NOTE]
> This approach provides the highest level of stability by explicitly linking the broadcasted business logic (Cubit) to the physical UI lifecycle (Widget State).
