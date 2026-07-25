import '../../core/models/report_item_model.dart';
import '../../data_source/remote/report/model/report_dto_model.dart';
import '../../data_source/remote/report/report_service.dart';
import '../../generated/l10n.dart';
import '../../ui/presenters/report/bloc/report_step.dart';

class ReportRepository {
  final ReportService _service;

  ReportRepository(this._service);

  Future<ReportDataBundle<SalesOverviewResponse>> getSalesOverview({
    String? dateFrom,
    String? dateTo,
    String? subPlanId,
    String? search,
    int? page,
    bool includeSummary = true,
  }) {
    final futures = [
      _service.getSalesOverview(
        dateFrom: dateFrom,
        dateTo: dateTo,
        subPlanId: subPlanId,
        search: search,
        page: page,
        pageSize: 20,
      ),
      if (includeSummary)
        _service.getSalesOverviewSummary(
          dateFrom: dateFrom,
          dateTo: dateTo,
          subPlanId: subPlanId,
          search: search,
        )
      else
        Future.value(null),
    ];

    return Future.wait(futures).then((values) {
      return ReportDataBundle(
        response: values[0] as SalesOverviewResponse,
        summary: values[1] as ReportSummaryDtoModel?,
      );
    });
  }

  Future<ReportDataBundle<SalesByPlanResponse>> getSalesByPlan({
    String? dateFrom,
    String? dateTo,
    String? search,
    int? page,
    bool includeSummary = true,
  }) {
    final futures = [
      _service.getSalesByPlan(
        dateFrom: dateFrom,
        dateTo: dateTo,
        search: search,
        page: page,
        pageSize: 20,
      ),
      if (includeSummary)
        _service.getSalesByPlanSummary(
          dateFrom: dateFrom,
          dateTo: dateTo,
          search: search,
        )
      else
        Future.value(null),
    ];

    return Future.wait(futures).then((values) {
      return ReportDataBundle(
        response: values[0] as SalesByPlanResponse,
        summary: values[1] as ReportSummaryDtoModel?,
      );
    });
  }

  Future<ReportDataBundle<SalesByCategoryResponse>> getSalesByCategory({
    String? dateFrom,
    String? dateTo,
    String? parentCategoryId,
    String? search,
    int? page,
    bool includeSummary = true,
  }) {
    final futures = [
      _service.getSalesByCategory(
        dateFrom: dateFrom,
        dateTo: dateTo,
        parentCategoryId: parentCategoryId,
        search: search,
        page: page,
        pageSize: 20,
      ),
      if (includeSummary)
        _service.getSalesByCategorySummary(
          dateFrom: dateFrom,
          dateTo: dateTo,
          parentCategoryId: parentCategoryId,
          search: search,
        )
      else
        Future.value(null),
    ];

    return Future.wait(futures).then((values) {
      return ReportDataBundle(
        response: values[0] as SalesByCategoryResponse,
        summary: values[1] as ReportSummaryDtoModel?,
      );
    });
  }

  Future<ReportDataBundle<SalesByProductResponse>> getSalesByProduct({
    String? dateFrom,
    String? dateTo,
    String? categoryId,
    String? subPlanId,
    String? search,
    int? page,
    bool includeSummary = true,
  }) {
    final futures = [
      _service.getSalesByProduct(
        dateFrom: dateFrom,
        dateTo: dateTo,
        categoryId: categoryId,
        subPlanId: subPlanId,
        search: search,
        page: page,
        pageSize: 20,
      ),
      if (includeSummary)
        _service.getSalesByProductSummary(
          dateFrom: dateFrom,
          dateTo: dateTo,
          categoryId: categoryId,
          subPlanId: subPlanId,
          search: search,
        )
      else
        Future.value(null),
    ];

    return Future.wait(futures).then((values) {
      return ReportDataBundle(
        response: values[0] as SalesByProductResponse,
        summary: values[1] as ReportSummaryDtoModel?,
      );
    });
  }

  List<ReportItemModel> mapToDomain(dynamic response, ReportStep step) {
    if (response is SalesOverviewResponse) {
      return response.results.map((dto) {
        final dateTime = DateTime.tryParse(dto.createdAt ?? '');
        final date = dateTime != null ? _formatJalaliDate(dateTime) : null;
        final time = dateTime != null ? _formatTime(dateTime) : null;

        return ReportItemModel(
          id: dto.id,
          title: dto.id.length > 10 ? dto.id.substring(0, 10) : dto.id, // Fallback title
          amount: dto.orderTotal?.toStringAsFixed(0),
          tagLabel: dto.planName != null && dto.subPlanDuration != null
              ? '${dto.planName} - ${S.current.monthsCountLabel(dto.subPlanDuration.toString())}'
              : dto.planName,
          quantity: dto.lineItemCount?.toString(),
          date: date,
          time: time,
        );
      }).toList();
    } else if (response is SalesByPlanResponse) {
      return response.results.map((dto) => ReportItemModel(
        id: dto.subPlanId,
        title: dto.planName ?? '',
        secondaryLabel: S.current.subPlanNameLabel,
        amount: dto.totalSalesAmount?.toStringAsFixed(0),
        quantity: dto.totalOrders?.toString(),
        tagLabel: dto.planName != null && dto.subPlanDuration != null
            ? '${dto.planName} - ${S.current.monthsCountLabel(dto.subPlanDuration.toString())}'
            : dto.planName,
      )).toList();
    } else if (response is SalesByCategoryResponse) {
      return response.results.map((dto) => ReportItemModel(
        id: dto.categoryId,
        title: dto.categoryName ?? '',
        secondaryLabel: S.current.parentCategorySecondaryLabel,
        tagLabel: dto.parentCategoryName ?? "__",
        amount: dto.totalSalesAmount?.toStringAsFixed(0),
        quantity: dto.totalOrders?.toString(),
      )).toList();
    } else if (response is SalesByProductResponse) {
      return response.results.map((dto) => ReportItemModel(
        id: dto.productId,
        title: dto.productName ?? '',
        sku: dto.productSku,
        tagLabel: dto.categoryName,
        secondaryLabel: S.current.categoryLabel,
        amount: dto.basePrice,
        secondaryAmount: dto.totalSalesAmount?.toStringAsFixed(0),
        quantity: dto.totalOrders?.toString(),
      )).toList();
    }
    return [];
  }

  List<ReportSummaryMetric> mapSummaryToDomain(ReportSummaryDtoModel? summary, ReportStep step) {
    if (summary == null) return [];
    switch (step) {
      case ReportStep.sales:
        return [
          ReportSummaryMetric(label: S.current.totalSalesLabel, value: summary.totalSalesAmount?.toStringAsFixed(0) ?? '۰', isCurrency: true),
          ReportSummaryMetric(label: S.current.totalOrdersLabel, value: summary.totalOrders?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.totalItemsLabel, value: summary.totalLineItems?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.uniqueCustomersLabel, value: summary.uniqueCustomers?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.averageSalesAmountLabel, value: summary.avgOrderAmount?.toStringAsFixed(0) ?? '۰', isCurrency: true),
          ReportSummaryMetric(label: S.current.averageItemsPerOrderLabel, value: summary.avgItemsPerOrder?.toStringAsFixed(0) ?? '۰'),
        ];
      case ReportStep.plan:
        return [
          ReportSummaryMetric(label: S.current.totalPurchaseLabel, value: summary.totalSalesAmount?.toStringAsFixed(0) ?? '۰', isCurrency: true),
          ReportSummaryMetric(label: S.current.totalOrdersLabel, value: summary.totalOrders?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.totalItemsLabel, value: summary.totalLineItems?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.averageSalesPerPlanLabel, value: summary.avgSalesPerSubplan?.toStringAsFixed(0) ?? '۰', isCurrency: true),
        ];
      case ReportStep.category:
        return [
          ReportSummaryMetric(label: S.current.totalPurchaseLabel, value: summary.totalSalesAmount?.toStringAsFixed(0) ?? '۰', isCurrency: true),
          ReportSummaryMetric(label: S.current.totalOrdersLabel, value: summary.totalOrders?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.totalItemsLabel, value: summary.totalLineItems?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.averageSalesPerCategoryLabel, value: summary.avgSalesPerCategory?.toStringAsFixed(0) ?? '۰', isCurrency: true),
        ];
      case ReportStep.products:
        return [
          ReportSummaryMetric(label: S.current.totalSalesLabel, value: summary.totalSalesAmount?.toStringAsFixed(0) ?? '۰', isCurrency: true),
          ReportSummaryMetric(label: S.current.totalOrdersLabel, value: summary.totalOrders?.toString() ?? '۰'),
          ReportSummaryMetric(label: S.current.totalItemsLabel, value: summary.totalLineItems?.toString() ?? '۰'),
        ];
    }
  }

  String _formatJalaliDate(DateTime date) {
    // Basic formatting, real app might use a helper
    return '${date.year}/${date.month}/${date.day}'; 
  }

  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class ReportDataBundle<T> {
  final T response;
  final ReportSummaryDtoModel? summary;

  ReportDataBundle({required this.response, this.summary});
}
