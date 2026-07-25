# Walkthrough - Report Step Data Enhancement (Plan Step)

I have updated the "Sales by Plan" report mapping to correctly display the plan details and secondary labels.

## Changes Made

### 1. Localization Updates
Added `subPlanNameLabel` to the internationalization files to provide a descriptive label for the sub-plan name field.
- **Persian (`intl_fa.arb`)**: Added `"subPlanNameLabel": "نام زیر مجموعه"`
- **English (`intl_en.arb`)**: Added `"subPlanNameLabel": "Sub-plan Name"`

### 2. Report Repository Enhancement
Updated the `mapToDomain` method in [ReportRepository](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/repository/report/report_repository.dart) for the `SalesByPlanResponse` case:
- **Tag Label**: Now combines the plan name and its duration (e.g., "بتا بانک رفاه - ۶ ماهه") instead of just the plan name.
- **Secondary Label**: Changed from showing the duration to the static "نام زیر مجموعه" label, which aligns with the provided UI requirements.

## Verification
- Verified that the `tagLabel` concatenation logic handles null values gracefully.
- Confirmed that the `secondaryLabel` correctly uses the new localized string.
- The changes are isolated to the `SalesByPlanResponse` mapping, ensuring no regression in other report types.
