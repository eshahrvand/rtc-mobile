# Feature Spec: My Customers Screen

## 1. Overview
The My Customers screen displays a searchable list of customers.
Tapping a customer switches the screen to a detail view with two tabs: customer info and orders.
It is navigated to from the Drawer Menu.

---

## 2. User Flow

```
Drawer Menu → "مشتریان من"
    └── context.push(AppRoutes.customers)
            └── Customers Screen
                    ├── State: customerList
                    │       ├── AppBar (with back button)
                    │       ├── Search box (RtcTextField)
                    │       └── ListView of RtcCustomerItem
                    │               └── user taps an item
                    │                       └── State: customerDetail
                    │
                    └── State: customerDetail
                            ├── AppBar (with back button → returns to customerList state)
                            └── RtcTabBar (2 tabs)
                                    ├── Tab 1: اطلاعات مشتری
                                    │       └── read-only fields (RtcTextField readOnly: true)
                                    └── Tab 2: سفارش‌ها
                                            └── ListView of RtcCustomerOrderItem
```

---

## 3. State Management Specification

### Cubit: `CustomersCubit`
- Located at: `ui/presenters/customers/bloc/customers_cubit.dart`
- State file: `ui/presenters/customers/bloc/customers_state.dart`
- State built with **Freezed**

### State Fields
```
CustomersState {
  CustomersRequestStatus status,           // default: initial
  String errorMessage,                     // default: ''

  // Screen mode
  CustomersStep step,                      // default: customerList

  // Customer List
  List<CustomerItemModel> allCustomers,    // full list — default: []
  List<CustomerItemModel> filteredCustomers, // after search — default: []
  String searchQuery,                      // default: ''

  // Customer Detail
  CustomerDetailModel? selectedCustomer,  // default: null
  int selectedTabIndex,                   // default: 0
}
```

### Enum: `CustomersStep`
```
CustomersStep {
  customerList,
  customerDetail,
}
```

### Status Enum: `CustomersRequestStatus`
```
CustomersRequestStatus {
  initial,
  loading,
  success,
  error,
}
```

### Cubit Methods
| Method | Description |
|---|---|
| `init()` | fetches customer list on screen load |
| `onSearchChanged(String query)` | filters `filteredCustomers` from `allCustomers` — all logic in Cubit |
| `onCustomerTapped(CustomerItemModel customer)` | fetches customer detail, emits `step: customerDetail` |
| `onTabChanged(int index)` | emits `selectedTabIndex` |
| `backToList()` | emits `step: customerList`, clears `selectedCustomer` |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

### Filter Logic
- Search filtering runs entirely inside `CustomersCubit.onSearchChanged()`
- `filteredCustomers` is always what the UI renders — never filter in UI

---

## 4. Data Models

### `CustomerItemModel`
```dart
class CustomerItemModel {
  final String id;
  final String name;
  // add any other fields visible in customers_list_item.png
}
```

### `CustomerDetailModel`
```dart
class CustomerDetailModel {
  final String id;
  // add all fields visible in customers_detail_info.png
  final List<CustomerOrderItemModel> orders;
}
```

### `CustomerOrderItemModel`
```dart
class CustomerOrderItemModel {
  // add all fields visible in customers_order_item.png
}
```

---

## 5. UI Structure

```
CustomersScreen
├── BlocProvider<CustomersCubit>
├── MultiBlocListener            ← error snackbar
└── Scaffold
    ├── appBar: BlocBuilder → RtcAppBar (changes behavior per step)
    └── body: BlocBuilder (switches on state.step)
            ├── state.step == customerList → CustomersListView
            └── state.step == customerDetail → CustomersDetailView
```

### AppBar Behavior per Step
| Step | AppBar |
|---|---|
| `customerList` | `RtcAppBar(onBack: () => context.pop(), title: '...')` |
| `customerDetail` | `RtcAppBar(onBack: () => context.read<CustomersCubit>().backToList(), title: '...')` |

---

## 6. View: `CustomersListView`
**File:** `ui/presenters/customers/widget/customers_list_view.dart`

### Layout (from screenshot: `customers_list.png`)
- `RtcTextField` for search — `onChange` → `context.read<CustomersCubit>().onSearchChanged(value)`
- `ListView.builder` of `RtcCustomerItem`
- Each item tap → `context.read<CustomersCubit>().onCustomerTapped(customer)`
- List renders `state.filteredCustomers`

---

## 7. View: `CustomersDetailView`
**File:** `ui/presenters/customers/widget/customers_detail_view.dart`

### Layout (from screenshot: `customers_detail.png`)
- `RtcTabBar` at the top with 2 tabs
- `TabBarView` or `IndexedStack` driven by `state.selectedTabIndex`
- Tab change → `context.read<CustomersCubit>().onTabChanged(index)`

### Tab 1 — اطلاعات مشتری (from screenshot: `customers_detail_info.png`)
- All fields displayed using `RtcTextField(readOnly: true)`
- Fields are whatever is visible in the screenshot — no additions

### Tab 2 — سفارش‌ها (from screenshot: `customers_detail_orders.png`)
- `ListView.builder` of `RtcCustomerOrderItem`
- Data from `state.selectedCustomer.orders`

---

## 8. Component: `RtcCustomerItem`
**File:** `lib/widget/rtc_customer_item.dart`

### Constructor
```dart
RtcCustomerItem({
  required CustomerItemModel customer,
  required VoidCallback onTap,
})
```

### Layout
- Replicate **exactly** from screenshot `customers_list_item.png`
- All colors, text styles → `// TODO: replace with theme values`
- All icons → SVG via `rtc_image`

---

## 9. Component: `RtcCustomerOrderItem`
**File:** `lib/widget/rtc_customer_order_item.dart`

### Constructor
```dart
RtcCustomerOrderItem({
  required CustomerOrderItemModel order,
})
```

### Layout
- Replicate **exactly** from screenshot `customers_order_item.png`
- All colors, text styles → `// TODO: replace with theme values`

---

## 10. Component: `RtcTabBar`
**File:** `lib/widget/rtc_tab_bar.dart`
**Reusable across all screens that need tabs**

### Constructor
```dart
RtcTabBar({
  required List<String> tabs,
  required int selectedIndex,
  required Function(int) onTabChanged,
})
```

### Behavior
- Custom-built tab bar — **do not use Flutter's `TabBar`** or `DefaultTabController`
- Selected tab has a distinct visual style — replicate from screenshot exactly
- Tab change → calls `onTabChanged(index)` → Cubit emits `selectedTabIndex`
- **No local state** — `selectedIndex` always comes from Cubit state

### Style
- Replicate **exactly** from screenshot `customers_tab_bar.png`
- All colors, border, selected indicator → `// TODO: replace with theme values`

---

## 11. BlocListener Specification

```
listenWhen: (prev, curr) => prev.status != curr.status

listener reactions:
  if status == error → show error snackbar with state.errorMessage
```

Use **plain `if/else`** — no `maybeWhen`, `when`, `map`, or `maybeMap`.

---

## 12. UI Rules

- Replicate all screenshots **exactly** — no extra elements, no layout changes
- **All logic lives in `CustomersCubit`** — search, tab switching, step switching, data fetching
- No `Future`, `async`, `await`, or business logic inside any UI file
- No local `setState` — all state via Cubit
- All colors and text styles → `// TODO: replace with theme values`
- All icons → SVG via `rtc_image`
- Every file must stay under **150–200 lines** — extract to `widget/` if exceeded
- Navigation via **GoRouter only** — back via `context.pop()` from customerList step

---

## 13. File Structure

```
lib/
└── widget/
    ├── rtc_customer_item.dart
    ├── rtc_customer_order_item.dart
    └── rtc_tab_bar.dart                  # reusable across project

ui/presenters/customers/
├── customers.dart                        # BlocProvider + MultiBlocListener + Scaffold
├── bloc/
│   ├── customers_cubit.dart
│   └── customers_state.dart
└── widget/
    ├── customers_list_view.dart          # search + list
    └── customers_detail_view.dart        # tab bar + tab content
```

---

## 14. Figma Assets

Place screenshots in:
```
ui-figma/customers/
├── customers_list.png              ← full list screen
├── customers_list_item.png         ← single customer list item
├── customers_detail.png            ← detail screen overview
├── customers_detail_info.png       ← tab 1: customer info fields
├── customers_detail_orders.png     ← tab 2: orders list
├── customers_order_item.png        ← single order item
└── customers_tab_bar.png           ← tab bar component
```

The AI agent must read **all images** before writing any code.

---

## 15. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter only — `context.push()` to enter, `context.pop()` to exit
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix rule
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, lib/widget/ scan
- **`drawer_menu_spec.md`**: navigation trigger — "مشتریان من" item in drawer
- **`project_context_summary.md`**: full project rules and conventions