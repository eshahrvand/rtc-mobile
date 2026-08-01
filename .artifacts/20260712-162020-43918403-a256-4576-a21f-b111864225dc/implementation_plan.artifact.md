# Implementation Plan - Product Pagination in Pre-Invoice Step 2

Implement pagination for the product list in the Pre-Invoice flow (Step 2) to match the behavior of the main Products screen.

## Proposed Changes

### State Management

#### [MODIFY] [PreInvoiceState](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/bloc/pre_invoice_state.dart)
- Add fields to track product pagination:
    - `currentProductPage` (default: 1)
    - `hasMoreProducts` (default: false)
    - `isProductPaginationLoading` (default: false)

#### [MODIFY] [PreInvoiceCubit](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart)
- Update `_loadProducts()` to reset pagination fields when a new search or filter is applied.
- Implement `fetchProductsNextPage()`:
    - Check if already loading or no more products.
    - Fetch the next page of products from `_productRepo.getProducts`.
    - Append new products to `allProducts` and `filteredProducts`.
    - Update `currentProductPage` and `hasMoreProducts`.

### UI Layer

#### [MODIFY] [PreInvoiceStep2View](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/widget/pre_invoice_step2_view.dart)
- Add a `ScrollController` to `_PreInvoiceStep2ViewState`.
- Add an `_onScroll` listener to trigger `fetchProductsNextPage()` when scrolling near the bottom (matching `ProductsBody` behavior).
- Update the `ListView.builder`:
    - Attach the `ScrollController`.
    - Increase `itemCount` by 1 if `isProductPaginationLoading` is true.
    - In `itemBuilder`, show a `CircularProgressIndicator` if the index is at the end of the list.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no syntax errors.

### Manual Verification
- Open Pre-Invoice flow.
- Go to Step 2 (Select Products).
- Scroll down the product list and verify that more products are loaded automatically.
- Verify that filtering by category/brand or searching correctly resets the list and maintains pagination for the filtered results.
