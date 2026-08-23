# Implementation Plan: Always Show Product Prices on Tab 2 & Dynamic Plan Price Updates

## Goal Description
Currently, on Tab 2 (Products screen), product prices are hidden when no credit sub-plan is selected because the widget passes `showPrice: hasPlan` (where `hasPlan = selectedSubPlanId != null`). In addition, the catalog API returns `price` and `price_before_discount` for general products, and `plan_price` and `plan_price_before_discount` for plan-filtered products, but `ProductDtoModel` was only mapping `base_price` and `plan_price`.

This change enables displaying the base product price (`price`) directly from the API response when no plan is selected, and seamlessly updating the price to `plan_price` whenever the user selects a plan filter.

---

## User Review Required

> [!NOTE]
> - Product cards in Tab 2 will now consistently display prices (formatted with comma thousand-separators and the Rial currency icon).
> - When no plan is selected, `price` is displayed.
> - When a plan is selected (via the plan filter chip), `plan_price` is displayed and updated accordingly.
> - Discount badges and struck-through old prices will be displayed when `price_before_discount` / `plan_price_before_discount` is greater than the current price.

---

## Proposed Changes

### 1. Data Layer — Catalog DTO Model

#### [MODIFY] [`lib/data_source/remote/catalog/model/product_dto_model.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/data_source/remote/catalog/model/product_dto_model.dart)
- Add `@JsonKey(name: 'price') int? price`
- Add `@JsonKey(name: 'price_before_discount') int? priceBeforeDiscount`
- Add `@JsonKey(name: 'plan_price_before_discount') int? planPriceBeforeDiscount`
- Run `dart run build_runner build --delete-conflicting-outputs` to regenerate freezed & json serialization files (`product_dto_model.freezed.dart` and `product_dto_model.g.dart`).

---

### 2. Products Presenter — BLoC & View

#### [MODIFY] [`lib/ui/presenters/products/bloc/product_cubit.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/bloc/product_cubit.dart)
- Update `_mapToProductItemModel` to handle both plan-specific and general catalog prices:
  ```dart
  final currentPrice = state.selectedSubPlanId != null
      ? (dto.planPrice ?? dto.price ?? dto.basePrice ?? 0)
      : (dto.price ?? dto.basePrice ?? dto.planPrice ?? 0);

  num? finalOldPrice = state.selectedSubPlanId != null
      ? (dto.planPriceBeforeDiscount ?? dto.oldPrice)
      : (dto.priceBeforeDiscount ?? dto.oldPrice ?? dto.basePrice);

  if (finalOldPrice == null &&
      dto.discountPct != null &&
      dto.discountPct! > 0 &&
      currentPrice > 0) {
    finalOldPrice = currentPrice / (1 - (dto.discountPct! / 100));
  }
  ```
- Only show `oldPrice` if `finalOldPrice > currentPrice`.

#### [MODIFY] [`lib/ui/presenters/products/widget/products_body.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/products_body.dart)
- Update `RtcProductItem` instantiation to always show price:
  ```dart
  return RtcProductItem(
    product: product,
    showPrice: true,
    onTap: () {
      context.push(
        AppRoutes.productDetail,
        extra: {
          'productId': product.id,
          'subPlanId': state.selectedSubPlanId,
          'subPlanName': state.selectedSubPlanName,
          'showPrice': true,
        },
      );
    },
  );
  ```

---

### 3. Product Detail Presenter

#### [MODIFY] [`lib/ui/presenters/product_detail/bloc/product_detail_cubit.dart`](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/product_detail/bloc/product_detail_cubit.dart)
- Update price and old price resolution in `init` to support `dto.price` and `dto.priceBeforeDiscount` as fallbacks when no `subPlanId` is present.

---

## Verification Plan

### Automated Tests / Code Generation
1. Run `dart run build_runner build --delete-conflicting-outputs` to regenerate JSON models.
2. Run `dart analyze lib/data_source/remote/catalog/ lib/ui/presenters/products/ lib/ui/presenters/product_detail/` to ensure no lint or compilation errors.

### Manual Verification
1. **No Plan Selected**:
   - Open Tab 2 (کالاها / Products).
   - Verify all products display their base `price` (e.g. `120,000,000` ریال, `14,700,000` ریال).
   - If a product has a discount (e.g., refrigerator with 2% discount), verify the badge `2%` and strikethrough `15,000,000` are displayed.
2. **Plan Selected**:
   - Tap the Plan filter chip (طرح) and select a sub-plan (e.g. تارا ۶ ماهه).
   - Verify the product list updates and displays the corresponding `plan_price`.
3. **Product Detail**:
   - Tap on a product item and verify the detail screen displays the price correctly in both default mode and when a plan was selected.
