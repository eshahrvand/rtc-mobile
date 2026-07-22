# Walkthrough: Drawer Icon Visibility in Report Flow

I have modified the `RtcSearchAppBar` to allow disabling the drawer (hamburger) icon, and specifically disabled it for the Report flow as requested.

## Changes Made

### UI Components

#### [RtcSearchAppBar](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/widget/rtc_search_appbar.dart)
- Added a `showDrawerIcon` boolean parameter to the constructor (defaults to `true`).
- Updated the `build` method to conditionally render the leading drawer icon based on this parameter.

### Feature Screens

#### [ReportScreen](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/report.dart)
- Explicitly set `showDrawerIcon: false` when instantiating `RtcSearchAppBar`.

## Verification Results

### Manual Verification
- **Report Screen:** The drawer menu icon is now hidden, allowing the title to be properly centered without leading clutter.
- **Dashboard (Products/Orders):** Verified that `DashboardAppBar` still displays the drawer icon correctly because it uses the default value of `showDrawerIcon: true`.

render_diffs(file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/widget/rtc_search_appbar.dart)
render_diffs(file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/report.dart)
