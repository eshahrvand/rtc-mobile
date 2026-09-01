# Walkthrough: Product Price Display on Tab 2 & Detail Screen

Implemented price display in the Product Catalog (Tab 2) and Product Detail screens, ensuring base prices are shown when no plan is selected and dynamic plan prices are shown when a credit plan is selected.

---

## Changes Made

### 1. Data Model
#### [`lib/data_source/remote/catalog/model/product_dto_model.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/data_source/remote/catalog/model/product_dto_model.dart)
- Added `@JsonKey(name: 'price') int? price`
- Added `@JsonKey(name: 'price_before_discount') int? priceBeforeDiscount`
- Added `@JsonKey(name: 'plan_price_before_discount') int? planPriceBeforeDiscount`
- Regenerated JSON serializable and Freezed files with `build_runner`.

### 2. Products List (Tab 2)
#### [`lib/ui/presenters/products/bloc/product_cubit.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/bloc/product_cubit.dart)
- Updated `_mapToProductItemModel`:
  - **Plan selected**: Uses `dto.planPrice` for `price` and `dto.planPriceBeforeDiscount` for `oldPrice`.
  - **No plan selected**: Uses `dto.price` for `price` and `dto.priceBeforeDiscount` for `oldPrice`.
  - Removed reliance on `base_price` for Tab 2.
  - Strikethrough `oldPrice` is only displayed when `oldPrice > currentPrice`.

#### [`lib/ui/presenters/products/widget/products_body.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/products_body.dart)
- Set `showPrice: true` permanently on `RtcProductItem`.
- Passed `showPrice: true` when navigating to `ProductDetailScreen`.

### 3. Product Detail Screen
#### [`lib/ui/presenters/product_detail/bloc/product_detail_cubit.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/product_detail/bloc/product_detail_cubit.dart)
- Updated `init`:
  - **Plan selected (`subPlanId != null`)**: Uses `dto.planPrice` for `price` and `dto.planPriceBeforeDiscount` for `oldPrice`.
  - **No plan selected (`subPlanId == null`)**: Uses `dto.price` for `price` and `dto.priceBeforeDiscount` for `oldPrice`.
  - Removed reliance on `base_price`.

---

## Validation & Verification

1. **Build Runner**: `dart run build_runner build --delete-conflicting-outputs` completed with 68 generated outputs.
2. **Static Analysis**: `dart analyze` verified all modified files and confirmed 0 errors.
