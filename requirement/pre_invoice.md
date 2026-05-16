
# Feature Spec: Pre-Invoice Issuance Flow

## 1. Overview
A multi-step flow for issuing a pre-invoice.
Accessible from the Dashboard Drawer Menu.
The entire flow runs inside **one screen** with one Cubit.
Steps are driven by state — no separate routes per step.

---

## 2. User Flow

```
Dashboard Drawer Menu → "صدور پیش فاکتور"
    └── context.push(AppRoutes.preInvoice)
            └── PreInvoiceScreen (single screen, state-driven)
                    ├── Step 1: انتخاب طرح اعتباری
                    ├── Step 2: انتخاب کالاها
                    ├── Step 3: اطلاعات مشتری
                    ├── Step 4: بارگذاری مدارک
                    └── Step 5: بررسی نهایی و ثبت
                            ├── ثبت پیش فاکتور → context.go(AppRoutes.orderDetail)
                            └── ثبت و تخلیه   → (defined by developer)
```

---

## 3. State Management Specification

### Cubit: `PreInvoiceCubit`
- Located at: `ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart`
- State file: `ui/presenters/pre_invoice/bloc/pre_invoice_state.dart`
- Built with **Freezed**
- **One Cubit manages all 5 steps**

### Enum: `PreInvoiceStep`
```dart
enum PreInvoiceStep {
  creditPlan,      // Step 1
  products,        // Step 2
  customerInfo,    // Step 3
  documents,       // Step 4
  review,          // Step 5
}
```

### State Fields
```
PreInvoiceState {
  PreInvoiceRequestStatus status,          // default: initial
  String errorMessage,                     // default: ''

  // Step tracking
  PreInvoiceStep currentStep,              // default: creditPlan

  // Step 1 — Credit Plan
  List<CreditPlanItemModel> creditPlans,   // default: []
  String? selectedCreditPlanId,            // default: null

  // Step 2 — Products
  bool isSearchActive,                     // default: false
  String searchQuery,                      // default: ''
  List<PreInvoiceChipModel> filterChips,   // default: []
  int selectedChipIndex,                   // default: 0
  List<PreInvoiceProductModel> allProducts,
  List<PreInvoiceProductModel> filteredProducts,
  List<CartItemModel> cartItems,           // selected products — default: []
  bool isCartVisible,                      // bottom sheet state — default: false

  // Step 3 — Customer Info
  String customerIdQuery,                  // national ID search — default: ''
  CustomerInfoModel? customerInfo,         // null = not found yet
  bool customerSearchLoading,              // default: false

  // Step 4 — Documents
  String? mandatoryDocPath,               // selected image path — default: null
  String? optionalDocPath,                // selected image path — default: null

  // Step 5 — Review
  // data comes from steps 1–4 already in state — no new fields needed
}
```

### Status Enum
```dart
enum PreInvoiceRequestStatus {
  initial,
  loading,
  success,
  error,
  submitted,         // after "ثبت پیش فاکتور"
  submittedAndCleared, // after "ثبت و تخلیه"
}
```

### Cubit Methods
| Method | Description |
|---|---|
| `init()` | loads credit plans and product list |
| `goToStep(PreInvoiceStep step)` | emits `currentStep` — called by next/back buttons |
| `onCreditPlanSelected(String id)` | emits `selectedCreditPlanId` |
| `activateSearch()` | emits `isSearchActive: true` |
| `deactivateSearch()` | resets search — emits `isSearchActive: false` |
| `onSearchChanged(String query)` | filters `filteredProducts` — all logic in Cubit |
| `onChipSelected(int index)` | emits `selectedChipIndex`, re-filters products |
| `addToCart(PreInvoiceProductModel product)` | adds item to `cartItems` |
| `removeFromCart(String productId)` | removes item from `cartItems` |
| `showCart()` | emits `isCartVisible: true` |
| `hideCart()` | emits `isCartVisible: false` |
| `onCustomerIdChanged(String value)` | emits `customerIdQuery` |
| `searchCustomer()` | calls repository, emits `customerInfo` |
| `onCustomerFieldChanged(String field, String value)` | updates editable customer fields |
| `pickMandatoryDoc()` | opens gallery, emits `mandatoryDocPath` |
| `pickOptionalDoc()` | opens gallery, emits `optionalDocPath` |
| `submitPreInvoice()` | submits, emits `submitted` |
| `submitAndClear()` | submits and clears form, emits `submittedAndCleared` |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

---

## 4. Data Models

### `CreditPlanItemModel`
```dart
class CreditPlanItemModel {
  final String id;
  // all fields visible in pre_invoice_step1_item.png
}
```

### `PreInvoiceProductModel`
```dart
class PreInvoiceProductModel {
  final String id;
  // all fields visible in pre_invoice_step2_item.png
}
```

### `CartItemModel`
```dart
class CartItemModel {
  final String productId;
  final String name;
  final int quantity;
  // all fields visible in pre_invoice_step2_cart.png
}
```

### `CustomerInfoModel`
```dart
class CustomerInfoModel {
  // all fields visible in pre_invoice_step3.png — all editable
}
```

---

## 5. UI Structure

```
PreInvoiceScreen
├── BlocProvider<PreInvoiceCubit>
├── MultiBlocListener            ← navigation + error snackbar
└── Scaffold
    ├── appBar: RtcAppBar(onBack: ..., title: '...')
    └── body: BlocBuilder (switches on state.currentStep)
            ├── currentStep == creditPlan   → PreInvoiceStep1View
            ├── currentStep == products     → PreInvoiceStep2View
            ├── currentStep == customerInfo → PreInvoiceStep3View
            ├── currentStep == documents    → PreInvoiceStep4View
            └── currentStep == review       → PreInvoiceStep5View
```

### AppBar Back Button Behavior per Step
| Step | Back action |
|---|---|
| `creditPlan` (step 1) | `context.pop()` — exits the flow |
| All other steps | `context.read<PreInvoiceCubit>().goToStep(previousStep)` |

---

## 6. Shared Component: Step Indicator
**File:** `lib/widget/rtc_step_indicator.dart`

### Constructor
```dart
RtcStepIndicator({
  required int totalSteps,
  required int currentStepIndex,   // 0-based
})
```

### Layout (from screenshot: `pre_invoice_step_indicator.png`)
- Visual indicator showing current step out of total
- Replicate **exactly** from screenshot
- All colors → `// TODO: replace with theme values`

---

## 7. STEP 1 — انتخاب طرح اعتباری
**File:** `ui/presenters/pre_invoice/widget/pre_invoice_step1_view.dart`

### Layout (from screenshot: `pre_invoice_step1.png`)
```
Column
├── RtcStepIndicator(totalSteps: 5, currentStepIndex: 0)
├── Expanded → ListView of RtcCreditPlanItem
└── Next button (active always — selection required before proceeding)
```

### Component: `RtcCreditPlanItem`
**File:** `lib/widget/rtc_credit_plan_item.dart`

```dart
RtcCreditPlanItem({
  required CreditPlanItemModel plan,
  required bool isSelected,
  required VoidCallback onTap,
})
```
- Replicate **exactly** from `pre_invoice_step1_item.png`
- Selected state visually distinct — replicate from screenshot
- Tap → `context.read<PreInvoiceCubit>().onCreditPlanSelected(plan.id)`
- Next button active only when `state.selectedCreditPlanId != null`
- Next button tap → `context.read<PreInvoiceCubit>().goToStep(PreInvoiceStep.products)`

---

## 8. STEP 2 — انتخاب کالاها
**File:** `ui/presenters/pre_invoice/widget/pre_invoice_step2_view.dart`

### Layout (from screenshot: `pre_invoice_step2.png`)
```
Column
├── RtcStepIndicator(totalSteps: 5, currentStepIndex: 1)
├── AppBar search area — check RtcProductsAppBar first; reuse if compatible
├── RtcChipList (reuse from lib/widget/) — filter chips
├── Expanded → ListView of PreInvoiceProductItem
└── Bottom row:
    ├── cart icon button → cubit.showCart()
    └── Next button → goToStep(customerInfo)
```

### Component: Check Before Building
- **`RtcChipList` + `RtcChipItem`** → reuse from `lib/widget/` (built in Products screen)
- **Search AppBar** → check `RtcProductsAppBar`; reuse if the two-state pattern matches screenshot

### Product Item in this step
Check `lib/widget/rtc_product_item.dart` first.
- If it matches `pre_invoice_step2_item.png` → reuse with an "add to cart" action
- If it does not match → build `RtcPreInvoiceProductItem` in `lib/widget/`

### Cart Bottom Sheet
Triggered when `state.isCartVisible == true` via `BlocListener`:
```
listenWhen: (prev, curr) => prev.isCartVisible != curr.isCartVisible
listener:
  if state.isCartVisible == true → show bottom sheet
  if state.isCartVisible == false → close bottom sheet
```
- Bottom sheet shows list of `CartItemModel` items
- Layout: replicate **exactly** from `pre_invoice_step2_cart.png`
- Dismiss → `cubit.hideCart()`

---

## 9. STEP 3 — اطلاعات مشتری
**File:** `ui/presenters/pre_invoice/widget/pre_invoice_step3_view.dart`

### Layout (from screenshot: `pre_invoice_step3.png`)
```
Column
├── RtcStepIndicator(totalSteps: 5, currentStepIndex: 2)
├── RtcTextField for national ID search
│     onChange → cubit.onCustomerIdChanged(value)
│     onSubmit → cubit.searchCustomer()
├── (if customerSearchLoading) → loading indicator
├── (if customerInfo != null) → editable fields (RtcTextField — NOT readOnly)
└── Next button → goToStep(documents)
    (active only when customerInfo != null)
```

### Editable Fields
- All customer info fields use `RtcTextField` with `readOnly: false`
- Changes → `cubit.onCustomerFieldChanged(field, value)`
- Fields and their layout: replicate **exactly** from screenshot

---

## 10. STEP 4 — بارگذاری مدارک
**File:** `ui/presenters/pre_invoice/widget/pre_invoice_step4_view.dart`

### Layout (from screenshot: `pre_invoice_step4.png`)
```
Column
├── RtcStepIndicator(totalSteps: 5, currentStepIndex: 3)
├── Mandatory document box
│     tap → cubit.pickMandatoryDoc() → opens gallery
│     if mandatoryDocPath != null → show selected image inside box
├── Optional document box
│     tap → cubit.pickOptionalDoc() → opens gallery
│     if optionalDocPath != null → show selected image inside box
└── Next button → goToStep(review)
    (active only when mandatoryDocPath != null)
```

### Document Box
- Both boxes: replicate **exactly** from `pre_invoice_step4.png`
- Before selection: shows upload placeholder UI (icon + label)
- After selection: shows selected image inside the box
- Gallery picker logic lives entirely in Cubit — UI only calls `cubit.pickMandatoryDoc()`
- All colors → `// TODO: replace with theme values`

---

## 11. STEP 5 — بررسی نهایی و ثبت
**File:** `ui/presenters/pre_invoice/widget/pre_invoice_step5_view.dart`

### Layout (from screenshot: `pre_invoice_step5.png`)
```
Column
├── RtcStepIndicator(totalSteps: 5, currentStepIndex: 4)
├── Review content
│     (all widgets here already exist in other parts of the app — reuse them)
│     check lib/widget/ before building anything new
└── Bottom row (2 buttons):
    ├── ثبت پیش فاکتور → cubit.submitPreInvoice()
    └── ثبت و تخلیه   → cubit.submitAndClear()
```

### Component Reuse Check
Before writing any widget in this view, scan `lib/widget/` and existing screen widgets.
The spec states these widgets are already implemented — identify and reuse them.

---

## 12. BlocListener Specification

```dart
MultiBlocListener(
  listeners: [
    // Error handling
    BlocListener<PreInvoiceCubit, PreInvoiceState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == PreInvoiceRequestStatus.error) {
          // show error snackbar
        }
        if (state.status == PreInvoiceRequestStatus.submitted) {
          context.go(AppRoutes.orderDetail); // lands in order detail
          // back button of orderDetail goes to orders list (handled by router stack)
        }
        if (state.status == PreInvoiceRequestStatus.submittedAndCleared) {
          // developer defines behavior
        }
      },
    ),

    // Cart bottom sheet
    BlocListener<PreInvoiceCubit, PreInvoiceState>(
      listenWhen: (prev, curr) => prev.isCartVisible != curr.isCartVisible,
      listener: (context, state) {
        if (state.isCartVisible) {
          // show cart bottom sheet
        } else {
          // close cart bottom sheet if open
        }
      },
    ),
  ],
)
```

**No `maybeWhen`, `when`, `map`, or `maybeMap`.**

---

## 13. Navigation After Submission

After `submitPreInvoice()` succeeds:
```dart
context.go(AppRoutes.orderDetail);
```
- `context.go()` replaces the stack → back button in Order Detail goes to Orders List
- This matches the requirement: back from order detail → orders list (not pre-invoice flow)

---

## 14. UI Rules

- Replicate all screenshots **exactly** — no extra elements, no layout changes
- **All logic lives in `PreInvoiceCubit`** — step navigation, search, cart, gallery, submission
- No `Future`, `async`, `await`, or business logic inside any UI file
- No local `setState` — all state via Cubit
- **Reuse existing components** — check `lib/widget/` before building anything new
- All colors and text styles → `// TODO: replace with theme values`
- All icons → SVG via `rtc_image`
- Every file must stay under **150–200 lines** — extract if exceeded
- Navigation via **GoRouter only**

---

## 15. File Structure

```
lib/
└── widget/
    ├── rtc_step_indicator.dart          # new — reusable across project
    ├── rtc_credit_plan_item.dart        # new
    └── rtc_pre_invoice_product_item.dart  # new (only if rtc_product_item doesn't fit)

ui/presenters/pre_invoice/
├── pre_invoice.dart                     # BlocProvider + MultiBlocListener + Scaffold
├── bloc/
│   ├── pre_invoice_cubit.dart
│   └── pre_invoice_state.dart
└── widget/
    ├── pre_invoice_step1_view.dart
    ├── pre_invoice_step2_view.dart
    ├── pre_invoice_step3_view.dart
    ├── pre_invoice_step4_view.dart
    └── pre_invoice_step5_view.dart
```

---

## 16. Figma Assets

```
ui-figma/pre_invoice/
├── pre_invoice_step_indicator.png      ← step indicator component
├── pre_invoice_step1.png               ← step 1 full view
├── pre_invoice_step1_item.png          ← credit plan list item
├── pre_invoice_step2.png               ← step 2 full view
├── pre_invoice_step2_item.png          ← product item in step 2
├── pre_invoice_step2_cart.png          ← cart bottom sheet
├── pre_invoice_step3.png               ← step 3 full view
├── pre_invoice_step4.png               ← step 4 full view
└── pre_invoice_step5.png               ← step 5 full view
```

The AI agent must read **all images** before writing any code.

---

## 17. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter — `context.go()` after submission clears stack correctly
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix rule
- **`ui_figma_implementation_guideline.md`**: screenshot replication, lib/widget/ scan first
- **`products_screen_spec.md`**: `RtcChipList`, `RtcChipItem`, `RtcProductsAppBar` — check for reuse
- **`orders_screen_spec.md`**: Order Detail is the landing screen after submission
- **`project_context_summary.md`**: full project rules and widget inventory