# Feature Spec: Products Screen

## 1. Overview
The Products screen displays a filterable list of products.
It is accessed by tapping the second item (کالاها) in the bottom navigation bar of the Dashboard.

---

## 2. User Flow

```
Home Screen → Bottom Nav item #2 (کالاها)
    └── Products Screen
            ├── AppBar: default state (drawer icon + search icon)
            │       └── user taps search icon
            │               └── AppBar: search state (text field + close icon)
            │                       └── user types → filters product list
            │                       └── user taps close → back to default AppBar state
            │
            ├── Choice Chip List (horizontal scroll)
            │       └── user taps a chip → chip becomes selected
            │               └── some chips → open a BottomSheet (onTap registered, no logic yet)
            │
            └── Product List
                    └── each item → RtcProductItem component
```

---

## 3. State Management Specification

### Cubit: `ProductCubit`
- Located at: `ui/presenters/products/bloc/product_cubit.dart`
- State file: `ui/presenters/products/bloc/product_state.dart`
- State built with **Freezed**

### State Fields
```
ProductState {
  ProductRequestStatus status,          // default: initial
  String errorMessage,                  // default: ''

  // AppBar
  bool isSearchActive,                  // false = default appbar, true = search field visible
  String searchQuery,                   // current search input — default: ''

  // Choice Chips
  List<ProductChipModel> chips,         // chip list — default: []
  int selectedChipIndex,                // default: 0

  // Product List
  List<ProductItemModel> allProducts,   // full list from repository
  List<ProductItemModel> filteredProducts, // list after search/chip filter — default: []
}
```

### Status Enum: `ProductRequestStatus`
```
ProductRequestStatus {
  initial,
  loading,
  success,
  error,
}
```

### Cubit Methods
| Method | Description |
|---|---|
| `init()` | fetches chips and product list on screen load |
| `activateSearch()` | emits `isSearchActive: true` |
| `deactivateSearch()` | emits `isSearchActive: false`, clears `searchQuery`, resets `filteredProducts` |
| `onSearchChanged(String query)` | emits `searchQuery`, filters `filteredProducts` from `allProducts` |
| `onChipSelected(int index)` | emits `selectedChipIndex`, triggers filter logic |
| `onChipTap(ProductChipModel chip)` | called on tap — emits selection; BottomSheet logic added later by developer |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

### Filter Logic (lives entirely in Cubit)
- Search and chip filtering are combined
- Filtering runs inside `ProductCubit` — never in the UI
- `filteredProducts` is always what the UI renders

---

## 4. Data Models

### `ProductChipModel`
```dart
class ProductChipModel {
  final int id;
  final String label;
  final bool opensBottomSheet;   // true = this chip triggers a BottomSheet on tap
}
```

### `ProductItemModel`
```dart
class ProductItemModel {
  final String id;
  final String name;
  final String imageUrl;        // or asset path if local
  // add any other fields visible in the product item screenshot
}
```

---

## 5. UI Structure

```
ProductsScreen
├── BlocProvider<ProductCubit>
├── MultiBlocListener            ← error snackbar
└── Scaffold
    ├── appBar: BlocBuilder → RtcProductsAppBar (switches between default and search state)
    ├── body: BlocBuilder
    │   └── Column
    │       ├── RtcChipList (horizontal chip row)
    │       └── Expanded
    │           └── ListView (RtcProductItem × n)
    └── (no bottomNavigationBar — rendered by HomeScreen Scaffold)
```

---

## 6. Component: `RtcProductsAppBar`
**File:** `lib/widget/rtc_products_appbar.dart`
**Type:** Returns `PreferredSizeWidget` (used as `appBar:` in Scaffold)

### Two States (controlled by `state.isSearchActive`)

#### Default State (`isSearchActive == false`)
- Matches the style of `RtcAppBar`
- Left icon: drawer/menu icon → calls `scaffoldKey.currentState?.openDrawer()`
- Right icon: search icon → calls `context.read<ProductCubit>().activateSearch()`
- Title: visible (from screenshot)

#### Search State (`isSearchActive == true`)
- The two icons and title are **replaced** by:
    - A `RtcTextField` (or equivalent) for search input — takes full available width
    - A close/× icon on one side → calls `context.read<ProductCubit>().deactivateSearch()`
- Text field is auto-focused when search activates
- onChange → `context.read<ProductCubit>().onSearchChanged(value)`

### Constructor Parameters
```dart
RtcProductsAppBar({
  required bool isSearchActive,
  required String searchQuery,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required ProductCubit cubit,
})
```

### Style
- Replicate **exactly** from screenshots `products_appbar_default.png` and `products_appbar_search.png`
- All colors, icon sizes, text styles → `// TODO: replace with theme values`
- All icons are SVG

---

## 7. Component: `RtcChipList` + `RtcChipItem`
**Files:**
- `lib/widget/rtc_chip_list.dart` — horizontal scrollable chip row
- `lib/widget/rtc_chip_item.dart` — individual chip

### `RtcChipItem` Constructor
```dart
RtcChipItem({
  required ProductChipModel chip,
  required bool isSelected,
  required VoidCallback onTap,
})
```

### `RtcChipList` Constructor
```dart
RtcChipList({
  required List<ProductChipModel> chips,
  required int selectedIndex,
  required Function(int index, ProductChipModel chip) onChipTap,
})
```

### Behavior
- Horizontally scrollable row of chips
- Selected chip has a distinct visual style — replicate from screenshot exactly
- Tapping a chip calls `onChipTap` → Cubit handles selection and BottomSheet logic
- **BottomSheet is not implemented yet** — only `onTap` is wired up

### Style
- Replicate **exactly** from screenshot `products_chips.png`
- All colors, border, padding, selected style → `// TODO: replace with theme values`

---

## 8. Component: `RtcProductItem`
**File:** `lib/widget/rtc_product_item.dart`

### Constructor
```dart
RtcProductItem({
  required ProductItemModel product,
  required VoidCallback onTap,
})
```

### Layout
- Replicate **exactly** from screenshot `products_item.png`
- Show all fields visible in the screenshot
- All colors, text styles, border radius, shadow → `// TODO: replace with theme values`
- All icons/images: use project's SVG/image widget

---

## 9. BlocListener Specification

```
listenWhen: (prev, curr) => prev.status != curr.status

listener reactions:
  if status == error → show error snackbar with state.errorMessage
```

Use **plain `if/else`** — no `maybeWhen`, `when`, `map`, or `maybeMap`.

---

## 10. UI Rules

- Replicate all screenshots **exactly** — no extra elements, no layout changes
- **All logic lives in `ProductCubit`** — search filtering, chip selection, data fetching
- No `Future`, `async`, `await`, or business logic inside any UI file
- All colors and text styles → `// TODO: replace with theme values`
- All icons are **SVG**
- Each file must stay under **150–200 lines** — extract if exceeded
- Navigation via **GoRouter only** — never `Navigator.push`
- This screen is rendered inside the `HomeScreen` Scaffold — it does **not** have its own `bottomNavigationBar`

---

## 11. File Structure

```
lib/
└── widget/
    ├── rtc_products_appbar.dart
    ├── rtc_chip_list.dart
    ├── rtc_chip_item.dart
    └── rtc_product_item.dart

ui/presenters/products/
├── products.dart
├── bloc/
│   ├── product_cubit.dart
│   └── product_state.dart
└── widget/
    └── (extracted sub-widgets if products.dart exceeds 200 lines)
```

---

## 12. Figma Assets

Place screenshots in:
```
ui-figma/products/
├── products_overview.png          ← full screen overview
├── products_appbar_default.png    ← appbar default state (2 icons)
├── products_appbar_search.png     ← appbar search state (text field + close)
├── products_chips.png             ← choice chip list
└── products_item.png              ← single product list item
```

The AI agent must read **all images** before writing any code.

---

## 13. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter only
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix rule
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, lib/widget/ scan
- **`home_screen_spec.md`**: bottom nav index 1 triggers navigation to this screen