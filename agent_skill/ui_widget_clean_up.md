# UI Widget Cleanup & Structural Refactor

## Context

This is a Flutter project using BLoC/Cubit, Clean Architecture, and GoRouter.
The goal is a **pure structural cleanup** of UI widget files — no behavioral changes of any kind.

---

## ⛔ Absolute Constraint — NON-NEGOTIABLE

> **Under NO circumstances may the current behavior, UI appearance, state emissions, or navigation change.**
> This rule has zero exceptions. Even if a change would result in the best app in the world — **do not make it.**
> When in doubt about whether a change affects behavior: **do not make it.**

---

## Step 1 — Investigate First (Do NOT write any code yet)

Before touching any file:

1. Read the entire target widget file(s) from top to bottom
2. List every private widget method (`_buildXxx()`) and note its approximate line count
3. Identify every formula or calculation inside the widget (e.g. price * discount, conditions with math)
4. Identify every conditional block with **more than 2 branches** used to determine UI state (e.g. button color, icon, label based on loading/active/disabled/error states)
5. Identify any logic that belongs in the Cubit but has leaked into the UI (e.g. filtering a list, computing a derived value, deciding which state to show)
6. Only after completing this audit, proceed to Step 2

---

## Step 2 — Split Oversized Files (300-line Rule)

- Each widget file must not exceed **~300 lines**
- If a file exceeds this, extract widgets into separate files (see Step 3)
- Do not artificially split a widget just to hit the number — only split at natural boundaries

---

## Step 3 — Extract Private Widgets into Separate Files

### Rule
No `_buildXxx()` private methods allowed. Every widget that was previously a private method must become a separate `StatelessWidget` or `StatefulWidget` class in its **own file**.

### File Location
Place extracted widgets in a `widgets/` subfolder next to the screen file.
Follow the existing folder convention of the project:

```
lib/features/auth/widgets/
lib/features/orders/widgets/
lib/features/preinvoice/widgets/
```

### Naming Convention
- File: `snake_case.dart` — e.g. `order_card_item.dart`
- Class: `PascalCase` — e.g. `OrderCardItem`
- Follow the existing `Rtc` prefix convention if used in this project — e.g. `RtcOrderCardItem`

### What to Pass as Parameters
- Pass **only what the widget needs to render** — no extra context, no full state objects if only 1–2 fields are needed
- Constructor parameters must match exactly what the original `_buildXxx()` method received
- Do not add or remove any parameter

---

## Step 4 — Move Formulas to Config

Any formula or calculation found in the UI layer must be moved to a dedicated file under `lib/config/`.

### Rules
- Create a new file named after the feature, e.g. `lib/config/order_calculations.dart`
- Extract the formula into a `static` function or a top-level function
- Replace the inline formula in the UI with a call to that function
- The function must produce **identical output** to the original inline formula — no rounding changes, no type changes

### Example
```dart
// Before — inside widget
final discountedPrice = price - (price * discountRate);

// After — in lib/config/order_calculations.dart
static double calculateDiscountedPrice(double price, double discountRate) {
  return price - (price * discountRate);
}

// In widget
final discountedPrice = OrderCalculations.calculateDiscountedPrice(price, discountRate);
```

---

## Step 5 — Move Misplaced Logic to Cubit

If any logic that belongs in the Cubit has leaked into the UI, move it.

### What counts as misplaced logic
- Filtering or sorting a list inside the widget
- Computing a derived value (e.g. total, difference, percentage)
- Deciding which state or status to show based on multiple raw fields
- Any `if/else` chain that computes a **value** (not just picks a color or icon for display)

### What does NOT count (leave it in the UI)
- Picking a color, icon, or text based on a state value already in Cubit
- Padding, margin, and layout decisions
- Animation triggers

### Rules
- Move the logic into the appropriate Cubit method or getter
- Expose the result as a new field on the existing **state class**
- The widget reads the new state field — it does not re-compute anything
- **The emitted state values and the conditions that trigger `emit()` must not change**
- Do not add a new Cubit method that triggers a new `emit()` — only add a derived getter or move computation into an existing flow

---

## Step 6 — Replace Multi-Branch Conditionals with Switch

Any conditional with **more than 2 branches** used to determine a UI property (color, icon, label, border, visibility) must be converted to a `switch` expression or `switch` statement.

### File Location
Group all switch helpers for a single flow into one file:

```
lib/features/orders/widgets/order_status_ui_helpers.dart
lib/features/preinvoice/widgets/preinvoice_ui_helpers.dart
```

### Example
```dart
// Before — in widget
Color buttonColor;
if (state.isLoading) {
  buttonColor = Colors.grey;
} else if (state.isSuccess) {
  buttonColor = Colors.green;
} else if (state.isError) {
  buttonColor = Colors.red;
} else {
  buttonColor = Colors.blue;
}

// After — in *_ui_helpers.dart
static Color resolveButtonColor(MyState state) => switch (state) {
  MyState(isLoading: true) => Colors.grey,
  MyState(isSuccess: true) => Colors.green,
  MyState(isError: true) => Colors.red,
  _ => Colors.blue,
};

// In widget
final buttonColor = MyUiHelpers.resolveButtonColor(state);
```

---

## Step 7 — Readability Pass

After all structural changes are done, do a final readability pass on each file:

- Remove any commented-out code that has no purpose
- Replace magic numbers with named `const` values where the meaning is unclear (e.g. `const double kCardBorderRadius = 8;`)
- Ensure consistent spacing between methods (one blank line between methods)
- Do NOT rename state fields, Cubit methods, or model properties — only local variables and constants

---

## Step 8 — Double Check (Required)

Before submitting any output, verify the following for **every file touched**:

- [ ] No `_buildXxx()` private method remains — all extracted to separate files
- [ ] No file exceeds ~300 lines
- [ ] All extracted widget files are in the correct `widgets/` subfolder
- [ ] All formulas moved to `lib/config/` and replaced with function calls
- [ ] All misplaced logic moved to Cubit with no new `emit()` calls added
- [ ] All multi-branch conditionals (3+) converted to switch
- [ ] No UI appearance has changed
- [ ] No state emission has changed
- [ ] No navigation or routing has changed
- [ ] No new packages added
- [ ] `build_runner` was NOT run
- [ ] No unrelated files were modified

---

## General Rules

- Investigate the full file before writing any code
- Make the smallest possible change that achieves each goal
- If a refactor step is ambiguous or risky, skip it and add a `// TODO: review` comment
- Never add dependencies
- Never run `build_runner`
- Never modify files not related to the target screen/widget