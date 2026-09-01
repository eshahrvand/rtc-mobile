# Implementation Plan - Fix Wallet Balance & Credit Verification in Settlement

## Goal Description
Fix the issue in order settlement where selecting wallet payment incorrectly assumes sufficient wallet/credit balance, ignores HTTP 422 errors (`insufficient_pocket_balance`, `credit_limit_exceeded`), leaves the "پرداخت با کیف پول" (Pay with Wallet) button active, and throws unhandled 422 & 500 DioExceptions.

---

## Root Cause Analysis
1. **HTTP 422 Ignored in Error Catching:**
   In [`OrdersCubit.initiateSettlement`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/orders/bloc/orders_cubit.dart#L834-L856), the cubit was only checking `apiError?.statusCode == 400`. When the backend returns HTTP **422** with error codes like `insufficient_pocket_balance` or `credit_limit_exceeded`, the check failed, leaving `isWalletBalanceSufficient` as `true` (its initial default value).
2. **Premature `isWalletBalanceSufficient: true` State:**
   When the user selects the wallet settlement method, `isWalletBalanceSufficient` was not set to `false` (pending validation), causing the UI to briefly or permanently treat the wallet as having sufficient balance.
3. **Unhandled DioExceptions & 500 Error Cascade:**
   Because `initiateSettlement.catchError` re-threw `throw e;`, an unhandled 422 error was thrown in the runtime. Since the button remained active, clicking "پرداخت با کیف پول" proceeded to invoke `settle`, causing a secondary HTTP 500 server crash because the reservation failed.

---

## Proposed Changes

### Orders BLoC

#### [MODIFY] [`lib/ui/presenters/orders/bloc/orders_cubit.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/orders/bloc/orders_cubit.dart)

1. **In `selectSettlementMethod`:**
   - Reset `isWalletBalanceSufficient: false` when selecting `wallet_debit` or `wallet` so the button and status wait for backend confirmation.
2. **In `initiateSettlement`:**
   - Extend the error condition in `catchError` to handle status codes `400`, `422`, as well as error codes `insufficient_pocket_balance` and `credit_limit_exceeded`.
   - Explicitly emit `isWalletBalanceSufficient: false` and set the descriptive `errorMessage`.
   - Remove `throw e;` to avoid unhandled async exceptions in Flutter runtime.
3. **In `confirmSettlement`:**
   - Guard against executing settlement if `isWalletBalanceSufficient == false` for wallet methods.
   - Add `.catchError` in `performSettle()` to handle and display any errors properly in state instead of crashing with unhandled exceptions.

---

## Verification Plan

### Automated / Static Analysis
- Run `dart analyze lib/ui/presenters/orders/bloc/orders_cubit.dart` to verify syntax and type safety.

### Manual Verification
1. Navigate to an Order awaiting settlement in the Order Detail screen.
2. Open the settlement method selector and choose **تسویه از طریق کیف پول (Wallet Settlement)**.
3. Verify that if the wallet has insufficient balance or exceeds credit limit (HTTP 422), the status banner correctly displays red with "موجودی کیف پول کافی نیست" (or credit limit exceeded message), the payment button is disabled, and no unhandled 422 or 500 exceptions occur.
