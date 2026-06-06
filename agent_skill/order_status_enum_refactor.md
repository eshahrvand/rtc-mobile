# Order Status Enum Refactor

## Context

Currently, the server returns order statuses as English strings (e.g. `'pre_invoice'`, `'approved'`).
There is a `_mapStatus()` function that maps these English values to Persian strings for display.
The bug is that some parts of the UI are comparing against the **Persian mapped string** instead of the raw server value:

```dart
// ❌ Current broken pattern — comparing against Persian display string
widget.order.status == 'پیش فاکتور'

// ✅ Correct pattern — compare against the raw English server value
widget.order.orderStatus == OrderStatus.preInvoice
```

The goal of this task is to introduce a proper `OrderStatus` enum and replace all status comparisons with it, while keeping Persian strings exclusively for UI display.

---

## ⛔ Absolute Constraint — NON-NEGOTIABLE

> **Under NO circumstances may the current behavior of the app change.**
> This is a pure structural refactor. Every condition that was previously `true` must remain `true`. Every condition that was previously `false` must remain `false`.
> If you are unsure whether a change affects behavior, **do not make it.**

---

## Step 1 — Investigate First (Do NOT write any code yet)

Search the entire codebase and find **every place** where `order.status` (or any status field) is:

1. **Compared** — e.g. `== 'پیش فاکتور'`, `== 'pre_invoice'`, used inside `if`, `switch`, ternary `? :`, or `when`
2. **Displayed** — passed to a Text widget, mapped via `_mapStatus()`, or used inside a localization call
3. **Received from the server** — the field name in the model (e.g. `OrderModel.status`, JSON key `"status"`)
4. **Stored** — inside any Cubit state, model, or local variable

Build a full list before proceeding.

---

## Step 2 — Create the Enum

Create a new file:
**`lib/core/enums/order_status.dart`**

```dart
enum OrderStatus {
  preInvoice,
  approved,
  rejected,
  underReview,
  awaitingSettlement,
  expired,
  unknown;

  /// Parses the raw English string received from the server.
  static OrderStatus fromString(String value) {
    switch (value) {
      case 'pre_invoice':
        return OrderStatus.preInvoice;
      case 'approved':
        return OrderStatus.approved;
      case 'rejected':
        return OrderStatus.rejected;
      case 'under_review':
        return OrderStatus.underReview;
      case 'awaiting_settlement':
        return OrderStatus.awaitingSettlement;
      case 'expired':
        return OrderStatus.expired;
      default:
        return OrderStatus.unknown;
    }
  }

  /// Returns the Persian display string for UI only.
  String toDisplayString() {
    switch (this) {
      case OrderStatus.preInvoice:
        return 'پیش فاکتور';
      case OrderStatus.approved:
        return 'تایید شده';
      case OrderStatus.rejected:
        return 'رد شده';
      case OrderStatus.underReview:
        return 'در انتظار تایید';
      case OrderStatus.awaitingSettlement:
        return 'در انتظار تسویه';
      case OrderStatus.expired:
        return 'منقضی شده';
      case OrderStatus.unknown:
        return '';
    }
  }
}
```

---

## Step 3 — Update the Model

In the `OrderModel` (or wherever `status` is deserialized from JSON):

1. Add a new getter or field of type `OrderStatus`:

```dart
// Add this alongside the existing raw `status` String field — do NOT remove the raw field
OrderStatus get orderStatus => OrderStatus.fromString(status);
```

> **Do NOT remove the existing `String status` field.** Only add the new getter next to it.
> The raw string field must remain intact for any serialization or API logic that depends on it.

---

## Step 4 — Replace All Comparisons

Find every comparison identified in Step 1 and replace it:

| Before (broken) | After (correct) |
|---|---|
| `order.status == 'پیش فاکتور'` | `order.orderStatus == OrderStatus.preInvoice` |
| `order.status == 'pre_invoice'` | `order.orderStatus == OrderStatus.preInvoice` |
| `order.status == 'تایید شده'` | `order.orderStatus == OrderStatus.approved` |
| `order.status == 'رد شده'` | `order.orderStatus == OrderStatus.rejected` |
| `order.status == 'در انتظار تایید'` | `order.orderStatus == OrderStatus.underReview` |
| `order.status == 'در انتظار تسویه'` | `order.orderStatus == OrderStatus.awaitingSettlement` |
| `order.status == 'منقضی شده'` | `order.orderStatus == OrderStatus.expired` |
| `switch (order.status) { case 'pre_invoice': ... }` | `switch (order.orderStatus) { case OrderStatus.preInvoice: ... }` |

Apply the same replacement pattern for any ternary or nested condition.

---

## Step 5 — Replace All Display Usages

Find every place where `_mapStatus(order.status)` or a Persian status string is used **for display** (inside a `Text`, `subtitle`, `label`, etc.) and replace it with:

```dart
order.orderStatus.toDisplayString()
```

Then **delete** the old `_mapStatus()` function entirely (only after confirming no remaining references to it exist).

---

## Step 6 — Self-Check Before Finishing

- [ ] `lib/core/enums/order_status.dart` created with all 6 statuses + `unknown`
- [ ] The raw `String status` field in the model is **untouched**
- [ ] The `orderStatus` getter is added to the model
- [ ] Every Persian string comparison is replaced with an enum comparison
- [ ] Every English string comparison is replaced with an enum comparison
- [ ] `_mapStatus()` is deleted and replaced everywhere with `.toDisplayString()`
- [ ] No display logic uses raw strings anymore
- [ ] No comparison logic uses Persian strings anymore
- [ ] `build_runner` was NOT run
- [ ] No unrelated files were modified
- [ ] No new packages were added

---

## General Rules

- Investigate the full codebase before writing any code
- Make only the changes described — nothing more
- Never modify unrelated files
- Never add unnecessary dependencies
- Never run `build_runner`
- If a usage is ambiguous, keep the old behavior and add a `// TODO: verify` comment next to it