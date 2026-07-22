# Walkthrough: Report Summary Metrics Alignment

I have aligned the summary metrics (the horizontal cards at the top of the report results) for each of the four report flows according to your specific requirements.

## Changes Made

### [ReportCubit](file:///Users/mahdi/StudioProjects/rtc_mobile/lib/ui/presenters/report/bloc/report_cubit.dart)
I updated the `_generateMockMetrics` method to provide the exact items and ordering requested for each report type:

**1. Sales Report**
- مبلغ کل فروش (Total sales amount)
- تعداد کل سفارشات (Total number of orders)
- تعداد اقلام (Number of items)
- مشتریان منحصر به فرد (Unique customers)
- میانگین مبلغ فروش (Average sales amount)
- میانگین تعداد کالا در هر سفارش (Average number of items per order)

**2. Sales Plan Report**
- مبلغ کل خرید (Total purchase amount)
- تعداد کل سفارشات (Total number of orders)
- تعداد کل اقلام (Number of items)
- میانگین فروش هر طرح (Average sales per plan)

**3. Product Category Report**
- مبلغ کل خرید (Total purchase amount)
- تعداد کل سفارشات (Total number of orders)
- تعداد کل اقلام (Total number of items)
- میانگین فروش هر دسته‌بندی (Average sales per category)

**4. Product Report**
- مبلغ کل فروش (Total sales amount)
- تعداد کل سفارشات (Total number of orders)
- تعداد کل اقلام (Total number of items)

## Verification Results

| Report Flow | Summary Metrics Verified |
| :--- | :--- |
| **Sales** | [x] 6 items in correct order |
| **Sales Plan** | [x] 4 items in correct order |
| **Product Category** | [x] 4 items (Added Average sales per category) |
| **Product** | [x] 3 items in correct order |

> [!NOTE]
> All labels are in Persian to match the application's localization. No UI components or themes were modified.
