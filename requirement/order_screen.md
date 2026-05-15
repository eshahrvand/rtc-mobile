# Feature Spec: Orders Screen

## 1. Overview

The Orders screen displays a searchable list of orders.

It is accessed from **Tab 3** in Bottom Navigation.

The overall bottom navigation behavior must match the other existing tabs.

Tapping an order opens the **Order Detail** screen.

The AI agent must read all provided UI screenshots before writing any code.

---

## 2. User Flow

Bottom Navigation → Tab 3: "سفارشات"

```text
└── Orders Screen
        ├── Search AppBar
        ├── Badge List
        ├── ListView of RtcOrderItem
        │       └── user taps an item
        │               └── Order Detail Screen
        │
        └── Order Detail Screen
                ├── AppBar
                ├── Remaining Validity Time + Status Badge
                └── RtcTabBar (3 tabs)
                        ├── Tab 1: جزییات سفارش
                        ├── Tab 2: اطلاعات مالی
                        └── Tab 3: تاریخچه
```

---

## 3. State Management Specification

Cubit: `OrdersCubit`

Located at:

`ui/presenters/orders/bloc/orders_cubit.dart`

State file:

`ui/presenters/orders/bloc/orders_state.dart`

State built with Freezed.

---

### State Fields

```dart
OrdersState {
  OrdersRequestStatus status,          // default: initial
  String errorMessage,                 // default: ''

  List<OrderItemModel> allOrders,      // default: []
  List<OrderItemModel> filteredOrders, // default: []

  String searchQuery,                  // default: ''

  List<String> selectedBadges,         // default: []

  OrderDetailModel? selectedOrder,     // default: null

  int selectedTabIndex,                // default: 0

  bool isCreditPlanExpanded,           // default: true

  bool isFinancialSectionExpanded,     // default: true
}
```

---

### Status Enum

```dart
OrdersRequestStatus {
  initial,
  loading,
  success,
  error,
}
```

---

### Cubit Methods

| Method                              | Description                   |
| ----------------------------------- | ----------------------------- |
| init()                              | fetches orders on screen load |
| onSearchChanged(String query)       | filters filteredOrders        |
| onBadgeSelected(String badge)       | filters orders                |
| onOrderTapped(OrderItemModel order) | fetches order detail          |
| onTabChanged(int index)             | emits selectedTabIndex        |
| toggleCreditPlan()                  | toggles credit plan section   |
| toggleFinancialSection()            | toggles financial section     |

---

### Future Handling Rule

Every Future must use `.then().catchError()` — no try/catch.

---

### Filter Logic

Search filtering runs entirely inside `OrdersCubit`.

`filteredOrders` is always what the UI renders — never filter in UI.

---

## 4. Data Models

### OrderItemModel

```dart
class OrderItemModel {
  final String id;
}
```

---

### OrderDetailModel

```dart
class OrderDetailModel {
  final String id;
}
```

---

## 5. UI Structure

```text
OrdersScreen
├── BlocProvider<OrdersCubit>
├── MultiBlocListener
└── Scaffold
    ├── appBar
    └── body
            ├── Search AppBar
            ├── Badge List
            └── Orders List
```

---

## 6. View: OrdersScreen

File:

`ui/presenters/orders/orders.dart`

### Layout

#### 1. Search AppBar

Use the existing search appbar from:

Tab 2 → مشاهده کالا

if compatible.

If not suitable, create a matching equivalent.

---

#### 2. Badge List

Reuse the existing badge widget from:

Tab 2 → مشاهده کالا

---

#### 3. Orders List

Use:

```dart
ListView.builder
```

Each item:

```dart
RtcOrderItem
```

On tap:

```dart
context.read<OrdersCubit>().onOrderTapped(order)
```

List renders:

```dart
state.filteredOrders
```

---

## 7. View: Order Detail Screen

File:

`ui/presenters/orders/widget/order_detail_view.dart`

---

### Layout

#### 1. AppBar

Use existing `rtc_app_bar` if compatible.

---

#### 2. Remaining Validity Time + Status Badge

Display remaining order validity time exactly like screenshots.

The remaining time is a static value received from backend/service.

It is NOT a realtime countdown timer.

Do NOT use:

* Timer
* Timer.periodic
* Stream
* animation-based countdown
* local ticking logic

The displayed value only refreshes when the user re-enters the screen or when order detail is fetched again.

Display order status badge beside remaining validity time.

Supported statuses:

* پیش فاکتور
* منقضی شده
* در انتظار تسویه
* در انتظار تایید
* رد شده

Replicate exactly from screenshots.

---

#### 3. RtcTabBar

Tabs:

* جزییات سفارش
* اطلاعات مالی
* تاریخچه

Tab change:

```dart
context.read<OrdersCubit>().onTabChanged(index)
```

No local state.

---

## 8. Tab 1 — جزییات سفارش

Contains:

1. Collapsible credit plan section

2. Goods section

3. Customer info section

4. Uploaded documents section

Replicate exactly from screenshots.

No extra elements.

---

## 9. Tab 2 — اطلاعات مالی

Content must be generated exactly from screenshots.

Supports 2 states:

* Before settlement
* After settlement

Some sections are collapsible.

No extra elements.

---

## 10. Tab 3 — تاریخچه

Content must be generated exactly from screenshots.

Supports 2 states:

* Before settlement
* After settlement

No extra elements.

---

## 11. Component: RtcOrderItem

File:

`lib/widget/rtc_order_item.dart`

### Constructor

```dart
RtcOrderItem({
  required OrderItemModel order,
  required VoidCallback onTap,
})
```

---

### Layout

Replicate exactly from screenshots.

All colors and text styles:

```dart
// TODO: replace with theme values
```

All icons:

SVG via `rtc_image`

---

## 12. Component: RtcTabBar

Reuse existing:

`lib/widget/rtc_tab_bar.dart`

Do not rebuild.

---

## 13. BlocListener Specification

```dart
listenWhen: (prev, curr) => prev.status != curr.status
```

Listener reactions:

```dart
if (status == error)
```

show error snackbar with:

```dart
state.errorMessage
```

Use plain if/else.

Do not use:

* maybeWhen
* when
* map
* maybeMap

---

## 14. UI Rules

Replicate all screenshots exactly.

No extra elements.

No layout changes.

All logic lives inside `OrdersCubit`.

No Future, async, await, or business logic inside UI files.

No local setState.

All colors and text styles:

```dart
// TODO: replace with theme values
```

All icons:

SVG via `rtc_image`

Every file must stay under 150–200 lines.

Extract widgets if exceeded.

---

## 15. File Structure

```text
lib/
└── widget/
    └── rtc_order_item.dart

ui/presenters/orders/
├── orders.dart
├── bloc/
│   ├── orders_cubit.dart
│   └── orders_state.dart
└── widget/
    └── order_detail_view.dart
```

---

## 16. Figma Assets

Place screenshots in:

```text
ui-figma/orders/

```

The AI agent must read all images before writing any code.

---

## 16. Cross-Reference

* state_management_guideline.md
* routing_guideline.md
* ui_component_system_guideline.md
* ui_figma_implementation_guideline.md
* project_context_summary.md
