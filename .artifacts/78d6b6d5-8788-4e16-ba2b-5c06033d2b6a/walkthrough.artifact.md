# Walkthrough: Refined Unified Report Flow

I have refined the "Report" flow to align perfectly with the provided HTML source designs. The implementation now supports all four report states (Sales, Plan, Category, Products) with dynamic layout adjustments, integrated filters, and a unified item component.

## Key Changes

### 1. Enhanced Models & State
- **[MODIFY] [report_item_model.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/core/models/report_item_model.dart):** Added support for SKU, multi-level tags, secondary amounts, and time fields as required by the HTML structures. Added `ReportSummaryMetric` for the horizontal metrics row.
- **[MODIFY] [report_state.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/bloc/report_state.dart):** Included filter parameters (Plan, Category, Date) and a list of summary metrics to reflect the screen's real-time state.

### 2. UI Alignment (HTML-Based)
- **[NEW] [report_summary_card.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/widget/report_summary_card.dart):** Implemented the horizontal scrollable summary cards seen in the designs, supporting both numeric and currency values with RTL alignment.
- **[MODIFY] [report_item_widget.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/widget/report_item_widget.dart):** Completely refactored to a unified architecture that dynamically builds rows based on the report type.
    - **Sales:** Shows ID with `#`, items count, tag, amount, and date/time.
    - **Products:** Shows Title, SKU, Category Tag, Base Price row, Order Count row, and Total Sales row.
    - **Plan/Category:** Shows Title, Category Tag, Parent Label, Order Count, and Purchase Amount.
- **[MODIFY] [report.dart](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/report.dart):**
    - Set background to `#FAFAFA`.
    - Integrated the horizontal `ReportSummaryCard` row.
    - Added the "X results" label with primary brand styling.
    - Added filter chips row with RTL support.

### 3. Filter Integration
- **Integrated `FilterBottomSheet`:** Used for Plan and Category filters, including the "Parent Category" requirement.
- **Integrated `FilterDateBottomSheet`:** Used for selecting date ranges (Today, Last Week, etc.) with custom range support.

## Verification against HTML Sources

I have verified the following alignments:
- [x] **Sales Report:** Item header matches `#PF-1404-00125` format with items count and date/time footer.
- [x] **Product Report:** Item supports SKU below title and multiple rows for Base Price, Orders, and Total Sales.
- [x] **Plan/Category Reports:** Item displays tags, parent/sub labels, and purchase amounts correctly.
- [x] **Layout:** Background, horizontal metrics, and result counts match the HTML proportions.

> [!IMPORTANT]
> The filter chip logic uses the existing `RtcChipList` and `FilterBottomSheet` components from the pre-invoice flow to ensure functional consistency across the project.

> [!TIP]
> I have used `reverse: true` on the horizontal metrics list to maintain the correct Right-to-Left (RTL) reading order as seen in the HTML screenshots.
