# Walkthrough - Use API `count` for Product Count Display

I have updated the Pre-Invoice Step 2 to display the total product count as reported by the API, ensuring users see the correct total even when pagination is active.

## Changes Made

### Pre-Invoice Module

#### [pre_invoice_state.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/bloc/pre_invoice_state.dart)
- Added `totalProductCount` to the state to persist the total count from the API.

#### [pre_invoice_cubit.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart)
- Updated `_loadProducts` (initial load/filter) to set `totalProductCount` from the API response.
- Updated `fetchProductsNextPage` (pagination) to keep the `totalProductCount` updated from each response.

#### [pre_invoice_step2_view.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/pre_invoice/widget/pre_invoice_step2_view.dart)
- Changed the UI to display `state.totalProductCount` instead of the local list length.
- Added a check for `totalProductCount == 0` to hide the label when no products are found.

## Verification Results

### Manual Verification
- The count now correctly shows the total number of items in the database (e.g., "113 products found") instead of just the number of items currently loaded on the screen (e.g., "20 products found").
- The count remains stable or updates based on API data as the user scrolls, rather than incrementing with each pagination step.
