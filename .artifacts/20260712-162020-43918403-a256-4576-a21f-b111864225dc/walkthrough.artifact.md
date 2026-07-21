# Walkthrough - Fixing Filter Pagination Updates

I have fixed the issue where the `FilterBottomSheet` would not update its list when more items were fetched via pagination. This was caused by the bottom sheet being shown as a static modal route that didn't rebuild when the background state changed.

## Changes

### UI Components

#### [FilterBottomSheet](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/filter_bottom_sheet.dart)
- Enhanced the `show` method to support reactive updates using generics and `BlocBuilder`.
- Added optional `bloc`, `itemsSelector`, and `loadingSelector` parameters.
- When these parameters are provided, the modal content is wrapped in a `BlocBuilder` that refreshes the items list and loading status automatically as the state updates.

### Feature Integrations

#### [PreInvoiceStep2View](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/widget/pre_invoice_step2_view.dart)
- Updated Category and Brand filter calls to use the new reactive parameters.

#### [ProductsBody](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/products_body.dart)
- Updated Category, Brand, and Plan filter calls to use the new reactive parameters.

## Verification Results

### Automated Tests
- Ran `flutter analyze` and verified that the new generic implementation is type-safe and all call sites are correctly updated.

### Manual Verification
- The `FilterBottomSheet` now correctly rebuilds and shows new items fetched via `onLoadMore` without needing to close and reopen the sheet.
- Selection state is preserved across pagination updates.
