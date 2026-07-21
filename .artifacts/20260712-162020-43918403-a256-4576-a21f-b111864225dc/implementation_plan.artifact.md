# Implementation Plan - Fixing Filter Pagination Updates

The current `FilterBottomSheet` is shown as a modal route using a snapshot of items. When more items are fetched via pagination, the already-open bottom sheet does not rebuild to show the new items. This plan introduces a reactive update mechanism for the `FilterBottomSheet` using a `BlocBuilder` inside the modal builder.

## User Review Required

> [!IMPORTANT]
> To keep `FilterBottomSheet` generic while allowing reactive updates, I will introduce a new static method `showReactive` (or similar) that takes a `Bloc` and selectors. Alternatively, I will update the existing `show` method to support optional reactive parameters. I've opted to update `show` with optional parameters to maintain a single entry point for all filter sheets.

## Proposed Changes

### UI Component Layer

#### [MODIFY] [FilterBottomSheet](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/filter_bottom_sheet.dart)
- Update `FilterBottomSheet.show` to support generic types `<B extends StateStreamable<S>, S>`.
- Add optional parameters:
    - `B? bloc`: The Cubit/Bloc instance to listen to.
    - `List<FilterItem> Function(S)? itemsSelector`: A function to extract items from the state.
    - `bool Function(S)? loadingSelector`: A function to extract loading status from the state.
- Inside the `showModalBottomSheet` builder:
    - If `bloc` is provided, wrap the `FilterBottomSheet` in `BlocProvider.value` and `BlocBuilder`.
    - Pass the results of selectors to the `FilterBottomSheet` constructor.
    - **CRITICAL**: Ensure `initialSelectedId` is captured once outside the `BlocBuilder` to prevent local selection reset on state changes.

### Pre-Invoice Feature

#### [MODIFY] [PreInvoiceStep2View](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/widget/pre_invoice_step2_view.dart)
- Update `_showCategoryFilter` and `_showBrandFilter` to pass the `cubit` and selectors for items and loading status.

### Products Feature

#### [MODIFY] [ProductsBody](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/products/widget/products_body.dart)
- Update `_showFilterSheet` to use the reactive parameters for Category, Brand, and Plan filters.

---

## Verification Plan

### Automated Tests
- Run `flutter analyze` to verify the generic types and method signatures.

### Manual Verification
1.  Open the Products screen or Pre-Invoice Step 2.
2.  Open the Category filter.
3.  Scroll to the bottom of the list.
4.  Verify that more items are fetched (check logs) AND immediately appear in the list without closing/reopening the sheet.
5.  Verify that selecting an item before the pagination completes is not lost when the list updates.
6.  Repeat for Brand and Plan filters.
