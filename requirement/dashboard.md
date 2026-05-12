# Feature Spec: Dashboard Screen

## 1. Overview
The dashboard screen is the main dashboard of the application.
It is navigated to from the Splash screen when the user has a valid token.

---

## 2. User Flow

Splash (tokenValid)
└── Dashboard Screen
├── AppBar (rtc_appbar)
├── 4x Quick Access Containers (rtc_quick_access_item)
├── Message Container (rtc_message_card)
├── Pre-Invoice Container (rtc_pre_invoice_card)
├── Line Chart (rtc_line_chart_card)
├── Pie Chart Card #1 (rtc_pie_chart_card)
├── Pie Chart Card #2 (rtc_pie_chart_card) — same component, different data
├── Bar Chart Card (rtc_bar_chart_card)
├── Recent Orders List (rtc_order_item)
└── Bottom Navigation Bar (rtc_bottom_nav)


---

## 3. State Management Specification

### Cubit: `DashboardCubit`
- Located at: `ui/presenters/dashboard/bloc/dashboard_cubit.dart`
- State file: `ui/presenters/dashboard/bloc/dashboard_state.dart`
- State built with **Freezed**

### State Fields
DashboardState {
DashboardRequestStatus status,         // default: initial
String errorMessage,              // default: ''
int selectedNavIndex,             // bottom nav selected index — default: 0

// Quick access data
List<QuickAccessItemModel> quickAccessItems,   // default: []

// Message card
String messageText,               // default: ''
String messageIconPath,           // default: ''

// Line chart
List<LineChartDataModel> lineChartData,        // default: []

// Pie charts
List<PieChartItemModel> pieChart1Data,         // default: []
String pieChart1Title,            // default: ''
List<PieChartItemModel> pieChart2Data,         // default: []
String pieChart2Title,            // default: ''

// Bar chart
List<BarChartItemModel> barChartData,          // default: []
String barChartTitle,             // default: ''

// Recent orders
List<OrderItemModel> recentOrders,             // default: []
}


### Status Enum: `DashboardRequestStatus`
DashboardRequestStatus {
initial,
loading,
success,
error,
}


### Cubit Methods
| Method | Description |
|---|---|
| `init()` | called on screen load, fetches all dashboard data |
| `onNavItemSelected(int index)` | emits `selectedNavIndex` |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

---

## 4. Data Models

### `QuickAccessItemModel`
{
String title,
String iconPath,     // SVG asset path
String? badgeCount,  // optional badge
}


### `PieChartItemModel`
{
String label,        // e.g. "فروش رنگ"
double value,        // e.g. 20
Color color,         // slice color — provided by developer via theme
}


### `LineChartDataModel`
{
List<FlSpot> line1Data,
List<FlSpot> line2Data,
}


### `BarChartItemModel`
{
String label,
double value,
}


### `OrderItemModel`
{
String orderId,
String customerName,
String date,
String status,
String amount,
}


---

## 5. UI Structure

DashboardScreen
├── BlocProvider<DashboardCubit>
├── MultiBlocListener        ← error snackbar
└── Scaffold
├── appBar: RtcAppBar(...)
├── body: BlocBuilder
│   └── SingleChildScrollView
│       └── Column
│           ├── Row (4x RtcQuickAccessItem)
│           ├── RtcMessageCard
│           ├── RtcPreInvoiceCard
│           ├── RtcLineChartCard
│           ├── RtcPieChartCard (pieChart1)
│           ├── RtcPieChartCard (pieChart2)
│           ├── RtcBarChartCard
│           └── ListView (RtcOrderItem × n)
└── bottomNavigationBar: RtcBottomNav


---

## 6. Component: `RtcAppBar`
**File:** `lib/widget/rtc_appbar.dart`
**Type:** Returns `AppBar` (used as `appBar:` in `Scaffold`)

### Constructor Parameters
```dart
RtcAppBar({
  String? title,
  Function? onBack,
  String? backIconPath,      // SVG asset path — default: close icon
  double? elevation,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
})
```

### Behavior
- `centerTitle: true`
- If `onBack != null`: shows leading icon button using `rtc_image` (SVG), calls `onBack()` on tap
- If `onBack == null`: leading is empty `SizedBox`
- Background color, text color, shadow → `// TODO: replace with theme values`
- Icon color → `// TODO: replace with theme values`
- All icons are SVG — use the project's `rtc_image` widget (or Flutter SVG) for rendering

### Reference Pattern
See the code sample in Section 11 for structural reference.
**Do not copy colors or theme values from the sample** — those belong to a different project.

---

## 7. Component: `RtcQuickAccessItem`
**File:** `lib/widget/rtc_quick_access_item.dart`

### Constructor Parameters
```dart
RtcQuickAccessItem({
  required String title,
  required String iconPath,    // SVG asset path
  String? badgeCount,
  required VoidCallback onTap,
})
```

### Layout (from screenshot: `dashboard_quick_access.png`)
- Tappable container
- Icon centered (SVG)
- Title text below icon
- Optional badge on top-right corner
- All 4 items displayed in a `Row` with equal flex inside the dashboard screen

### Style
- All colors, border radius, shadow → `// TODO: replace with theme values`

---

## 8. Component: `RtcMessageCard`
**File:** `lib/widget/rtc_message_card.dart`

### Constructor Parameters
```dart
RtcMessageCard({
  required String message,
  required String iconPath,    // SVG asset path
})
```

### Layout (from screenshot: `dashboard_message_card.png`)
- Horizontal card: icon on one side, text on the other
- All icons are SVG — rendered via project's SVG widget
- All colors, border radius, padding → `// TODO: replace with theme values`

---

## 9. Component: `RtcPreInvoiceCard`
**File:** `lib/widget/rtc_pre_invoice_card.dart`

### Constructor Parameters
```dart
RtcPreInvoiceCard({
  required VoidCallback onTap,
})
```

### Layout (from screenshot: `dashboard_pre_invoice.png`)
- Tappable card
- Replicate layout exactly from screenshot
- All text content visible in screenshot is hardcoded (static UI, no dynamic data)
- All colors, radius, shadow → `// TODO: replace with theme values`

---

## 10. Component: `RtcLineChartCard`
**File:** `lib/widget/rtc_line_chart_card.dart`
**Package:** `fl_chart`

### Constructor Parameters
```dart
RtcLineChartCard({
  required List<FlSpot> line1Data,
  required List<FlSpot> line2Data,
  String? line1Label,
  String? line2Label,
})
```

### Chart Specification (from screenshot: `dashboard_line_chart.png`)
- Two `LineChartBarData` lines rendered on a single `LineChart`
- Each line has a distinct color → `// TODO: replace with theme color`
- Show dots on data points
- Grid lines visible → colors `// TODO: replace with theme values`
- X and Y axis labels visible
- Legend or label for each line visible
- Replicate axis behavior and grid density exactly from screenshot

### Style
- Card container: all colors, radius, shadow → `// TODO: replace with theme values`

---

## 11. Component: `RtcPieChartCard`
**File:** `lib/widget/rtc_pie_chart_card.dart`
**Package:** `fl_chart`

### Constructor Parameters
```dart
RtcPieChartCard({
  required String title,
  required List<PieChartItemModel> data,
})
```

### `PieChartItemModel`
```dart
class PieChartItemModel {
  final String label;    // e.g. "فروش رنگ"
  final double value;    // e.g. 20
  final Color color;
}
```

### Chart Specification (from screenshot: `dashboard_pie_chart.png`)
- `PieChart` from fl_chart
- Each `PieChartSectionData` uses `label` and `value` from model
- Show percentage or value inside or beside each slice — replicate from screenshot exactly
- Legend below or beside chart showing label + color indicator for each item
- Title displayed above the chart (from `title` parameter)
- Replicate layout, legend position, and label style exactly from screenshot

### Style
- Card container: all colors, radius, shadow → `// TODO: replace with theme values`
- Slice colors come from `PieChartItemModel.color` — set by caller

### Usage in Dashboard Screen
This component is used **twice** with different data:
```dart
RtcPieChartCard(
  title: state.pieChart1Title,
  data: state.pieChart1Data,
)

RtcPieChartCard(
  title: state.pieChart2Title,
  data: state.pieChart2Data,
)
```

---

## 12. Component: `RtcBarChartCard`
**File:** `lib/widget/rtc_bar_chart_card.dart`
**Package:** `fl_chart`

### Constructor Parameters
```dart
RtcBarChartCard({
  required String title,
  required List<BarChartItemModel> data,
})
```

### `BarChartItemModel`
```dart
class BarChartItemModel {
  final String label;
  final double value;
}
```

### Chart Specification (from screenshot: `dashboard_bar_chart.png`)
- `BarChart` from fl_chart
- Each `BarChartGroupData` maps to one `BarChartItemModel`
- X axis labels = `item.label`
- Y axis shows value scale
- Bar color → `// TODO: replace with theme color`
- Grid lines → `// TODO: replace with theme values`
- Title displayed above the chart (from `title` parameter)
- Replicate bar width, spacing, and grid density exactly from screenshot

### Style
- Card container: all colors, radius, shadow → `// TODO: replace with theme values`

---

## 13. Component: `RtcOrderItem`
**File:** `lib/widget/rtc_order_item.dart`

### Constructor Parameters
```dart
RtcOrderItem({
  required OrderItemModel order,
  required VoidCallback onTap,
})
```

### `OrderItemModel`
```dart
class OrderItemModel {
  final String orderId;
  final String customerName;
  final String date;
  final String status;
  final String amount;
}
```

### Layout (from screenshot: `dashboard_order_item.png`)
- Tappable list item
- Replicate all visible fields from screenshot exactly
- Status may have a color indicator → `// TODO: replace with theme color per status`
- Divider or spacing between items — replicate from screenshot

---

## 14. Component: `RtcBottomNav`
**File:** `lib/widget/rtc_bottom_nav.dart`

### Constructor Parameters
```dart
RtcBottomNav({
  required int selectedIndex,
  required Function(int) onItemSelected,
})
```

### Layout (from screenshot: `dashboard_bottom_nav.png`)
- Custom bottom navigation bar — **do not use Flutter's `BottomNavigationBar`**
- Build entirely from scratch using `Row`, `GestureDetector`, and SVG icons
- Number of items and their icons: **replicate exactly from screenshot**
- Selected item indicator: replicate style from screenshot exactly
- The bar must sit above the system navigation area — use `SafeArea` or `padding` accordingly
- **Critical:** screen content must scroll/end before reaching the bottom nav — it must never be hidden behind it
- All colors → `// TODO: replace with theme values`
- All icons are SVG

### Integration in DashboardScreen
```dart
Scaffold(
  bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
    builder: (context, state) => RtcBottomNav(
      selectedIndex: state.selectedNavIndex,
      onItemSelected: (index) =>
          context.read<DashboardCubit>().onNavItemSelected(index),
    ),
  ),
)
```

---

## 15. BlocListener Specification

listenWhen: (prev, curr) => prev.status != curr.status

listener reactions:
if status == error → show error snackbar with state.errorMessage


Use **plain `if/else`** — no `maybeWhen`, `when`, `map`, or `maybeMap`.

---

## 16. UI Rules

- **Replicate screenshots exactly** — no extra elements, no layout changes
- **Theme, colors, text styles** → added manually by developer after implementation — mark all as `// TODO`
- Each screen and widget file must stay under **150–200 lines**
- Navigation only via **GoRouter** — never `Navigator.push`
- All images and icons are **SVG** — use the project's SVG rendering widget
- `fl_chart` must be used for all charts (line, pie, bar)

### All Logic Belongs in the Cubit — No Exceptions
The UI layer is strictly for layout and rendering. Every piece of logic must live in `DashboardCubit`. This includes:

| Logic Type | Where it lives |
|---|---|
| API calls and data fetching | `DashboardCubit` |
| Data transformation and mapping | `DashboardCubit` |
| Chart data preparation | `DashboardCubit` |
| Filtering, sorting, calculations | `DashboardCubit` |
| Navigation decisions | `BlocListener` reacting to Cubit state |
| Bottom nav index tracking | `DashboardCubit.onNavItemSelected()` |
| Error handling | `DashboardCubit` → emits error status → UI shows snackbar |
| Loading state management | `DashboardCubit` |

**UI files must never contain:**
- `if` conditions based on business data (only on state fields for rendering)
- Any `Future`, `async`, or `await`
- Direct calls to repositories, services, or DAOs
- Any computation beyond simple null-checks for display purposes

The UI calls Cubit methods. The Cubit does the work. The UI renders the result.

---

## 17. File Structure

lib/
├── widget/                              # Shared reusable components
│   ├── rtc_appbar.dart
│   ├── rtc_quick_access_item.dart
│   ├── rtc_message_card.dart
│   ├── rtc_pre_invoice_card.dart
│   ├── rtc_line_chart_card.dart
│   ├── rtc_pie_chart_card.dart
│   ├── rtc_bar_chart_card.dart
│   ├── rtc_order_item.dart
│   └── rtc_bottom_nav.dart
│
└── ui/presenters/dashboard/
├── dashboard.dart                   # Root screen
├── bloc/
│   ├── dashboard_cubit.dart
│   └── dashboard_state.dart
└── widget/
└── (extracted sub-widgets if dashboard.dart exceeds 200 lines)


---

## 18. Figma Assets

Place screenshots in:
ui-figma/dashboard/
├── dashboard_overview.png           ← full screen overview
├── dashboard_quick_access.png       ← quick access items
├── dashboard_message_card.png       ← message container
├── dashboard_pre_invoice.png        ← pre-invoice container
├── dashboard_line_chart.png         ← line chart section
├── dashboard_pie_chart.png          ← pie chart component
├── dashboard_bar_chart.png          ← bar chart section
├── dashboard_order_item.png         ← single order list item
└── dashboard_bottom_nav.png         ← bottom navigation bar


The AI assistant must read **all images** before writing any code.

---

## 19. AppBar Code Reference

The following is a structural reference from another project.
**Use it only as a pattern guide — do not copy colors, theme values, or imports.**

```dart
// REFERENCE ONLY — do not copy colors or theme calls from this snippet
AppBar(
  centerTitle: true,
  leading: onBack != null
      ? GestureDetector(onTap: () => onBack(), child: SvgIcon(...))
      : SizedBox.shrink(),
  title: Text(title ?? ''),
  actions: actions ?? [],
  elevation: elevation ?? 0,
  bottom: bottom,
)
```

---

## 20. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter only, navigation from BlocListener or user action
- **`ui_component_system_guideline.md`**: 150–200 line limit, widget extraction, rtc_ prefix rule
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, `lib/widget/` scan process
- **`dependencies_guideline.md`**: `fl_chart` is an approved specialized library for data visualization
- **`Project_structure_schematic.md`**: dashboard folder structure and shared widget location