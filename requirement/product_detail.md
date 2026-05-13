# Feature Spec: Product Detail Screen

## 1. Overview
The Product Detail screen displays full information about a single product.
It is navigated to from the Products screen when the user taps on a product item.

---

## 2. User Flow

```
Products Screen
    └── user taps RtcProductItem
            └── context.push(AppRoutes.productDetail, extra: {'productId': product.id})
                    └── Product Detail Screen
                            ├── image gallery (horizontal scroll)
                            ├── name, price, old price, discount badge
                            ├── info badges
                            ├── technical specifications section
                            └── product description section
```

---

## 3. State Management Specification

### Cubit: `ProductDetailCubit`
- Located at: `ui/presenters/product_detail/bloc/product_detail_cubit.dart`
- State file: `ui/presenters/product_detail/bloc/product_detail_state.dart`
- State built with **Freezed**

### State Fields
```
ProductDetailState {
  ProductDetailRequestStatus status,       // default: initial
  String errorMessage,                     // default: ''
  ProductDetailModel? product,             // full product data — default: null
  int selectedImageIndex,                  // currently selected image — default: 0
}
```

### Status Enum: `ProductDetailRequestStatus`
```
ProductDetailRequestStatus {
  initial,
  loading,
  success,
  error,
}
```

### Data Model: `ProductDetailModel`
```dart
class ProductDetailModel {
  final String id;
  final String name;
  final String price;
  final String oldPrice;
  final String discountPercent;
  final List<String> imageUrls;          // list of image URLs/paths
  final List<ProductBadgeModel> badges;  // info badges
  final List<ProductSpecModel> specs;    // technical specifications
  final String description;              // product description text
}
```

### `ProductBadgeModel`
```dart
class ProductBadgeModel {
  final String label;
  final String value;
  final String? iconPath;    // SVG — optional
}
```

### `ProductSpecModel`
```dart
class ProductSpecModel {
  final String key;     // spec name  e.g. "رنگ"
  final String value;   // spec value e.g. "مشکی"
}
```

### Cubit Methods
| Method | Description |
|---|---|
| `init(String productId)` | fetches product detail by ID on screen load |
| `onImageSelected(int index)` | emits `selectedImageIndex` |

### Future Handling Rule
- Every `Future` must use `.then().catchError()` — **no `try/catch`**

### Development Placeholder Rule
During development, `init()` does **not** call a real API yet.
Instead, it emits mock data with the **same image repeated 5 times**:
```
imageUrls: [img, img, img, img, img]   // same image, 5 times
```
This placeholder stays until the real repository is connected.

---

## 4. UI Structure

```
ProductDetailScreen
├── BlocProvider<ProductDetailCubit>
├── MultiBlocListener            ← error snackbar
└── Scaffold
    ├── appBar: RtcAppBar(onBack: () => context.pop(), title: '')
    └── body: BlocBuilder
            └── (loading) → CircularProgressIndicator centered
            └── (success) → SingleChildScrollView
                    └── Column
                        ├── RtcProductImageGallery   ← image list + indicator
                        ├── product name, price block
                        ├── RtcProductBadgeList      ← horizontal badge row
                        ├── Divider
                        ├── technical specs section
                        ├── Divider
                        └── description section
```

---

## 5. Component: `RtcProductImageGallery`
**File:** `lib/widget/rtc_product_image_gallery.dart`

### Constructor
```dart
RtcProductImageGallery({
  required List<String> imageUrls,
  required int selectedIndex,
  required Function(int) onImageChanged,
})
```

### Layout (from screenshot: `product_detail_gallery.png`)
- Horizontal `PageView` or scrollable image list
- Page indicator dots below the images — selected dot distinct from others
- On page change → calls `onImageChanged(index)` → Cubit emits `selectedImageIndex`
- **No local state** — `selectedIndex` comes from Cubit state

### Style
- All colors, indicator sizes → `// TODO: replace with theme values`

---

## 6. Price Block
**Inline in screen body — not extracted unless line limit exceeded**

Layout (from screenshot: `product_detail_price.png`):
- Product name — prominent text
- Current price
- Old price — struck through
- Discount percent badge — visually distinct (color badge)

All colors and text styles → `// TODO: replace with theme values`

---

## 7. Component: `RtcProductBadgeList`
**File:** `lib/widget/rtc_product_badge_list.dart`

### Constructor
```dart
RtcProductBadgeList({
  required List<ProductBadgeModel> badges,
})
```

### Layout (from screenshot: `product_detail_badges.png`)
- Horizontal scrollable row of badge items
- Each badge shows: icon (SVG, optional) + label + value
- Replicate badge shape, spacing, and style exactly from screenshot

### Style
- All colors, border radius, padding → `// TODO: replace with theme values`

---

## 8. Technical Specifications Section
**Inline in screen body or extracted to `widget/` if needed**

Layout (from screenshot: `product_detail_specs.png`):
- Section title (from screenshot)
- List of `ProductSpecModel` items
- Each row: key on one side, value on the other
- Alternating row background or divider between rows — replicate from screenshot exactly

### Style
- All colors, text styles → `// TODO: replace with theme values`

---

## 9. Description Section
**Inline in screen body or extracted to `widget/` if needed**

Layout (from screenshot: `product_detail_description.png`):
- Section title (from screenshot)
- Description text body
- Replicate text layout, line height, and any expandable behavior visible in screenshot

### Style
- All colors, text styles → `// TODO: replace with theme values`

---

## 10. BlocListener Specification

```
listenWhen: (prev, curr) => prev.status != curr.status

listener reactions:
  if status == error → show error snackbar with state.errorMessage
```

Use **plain `if/else`** — no `maybeWhen`, `when`, `map`, or `maybeMap`.

---

## 11. UI Rules

- Replicate all screenshots **exactly** — no extra elements, no layout changes
- **All logic lives in `ProductDetailCubit`** — data fetching, image index tracking
- No `Future`, `async`, `await`, or business logic inside any UI file
- No local `setState` — all state via Cubit
- All colors and text styles → `// TODO: replace with theme values`
- All icons and images: use project's SVG/image widget
- Screen file must stay under **150–200 lines** — extract to `widget/` if exceeded
- Navigation via **GoRouter only** — back via `context.pop()`

---

## 12. File Structure

```
lib/
└── widget/
    ├── rtc_product_image_gallery.dart
    └── rtc_product_badge_list.dart

ui/presenters/product_detail/
├── product_detail.dart
├── bloc/
│   ├── product_detail_cubit.dart
│   └── product_detail_state.dart
└── widget/
    └── (extracted sub-widgets if product_detail.dart exceeds 200 lines)
```

---

## 13. Figma Assets

Place screenshots in:
```
ui-figma/product_detail/
├── product_detail_overview.png        ← full screen
├── product_detail_gallery.png         ← image gallery + indicator
├── product_detail_price.png           ← name, price, old price, discount
├── product_detail_badges.png          ← info badges row
├── product_detail_specs.png           ← technical specifications section
└── product_detail_description.png     ← description section
```

The AI agent must read **all images** before writing any code.

---

## 14. Cross-Reference
- **`state_management_guideline.md`**: `.then().catchError()`, BlocListener if/else, no maybeWhen
- **`routing_guideline.md`**: GoRouter only — `context.push()` to enter, `context.pop()` to go back
- **`ui_component_system_guideline.md`**: 150–200 line limit, rtc_ prefix rule
- **`ui_figma_implementation_guideline.md`**: screenshot replication rules, lib/widget/ scan
- **`products_screen_spec.md`**: navigation trigger point — tap on RtcProductItem