import 'package:intl/intl.dart';
import '../../core/models/commission_report_entry.dart';
import '../../core/models/report_item_model.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/date_time_utils.dart';
import '../../core/utils/id_formatter.dart';
import '../../data_source/remote/report/model/commission_dto_model.dart';
import '../../data_source/remote/report/report_service.dart';
import '../../generated/l10n.dart';

class CommissionReportRepository {
  final ReportService _service;

  CommissionReportRepository(this._service);

  Future<CommissionReportPage> getReport({
    int? year,
    int? month,
    String? search,
    String? storeId,
    int page = 1,
    bool includeSummary = true,
  }) {
    return Future.wait<Object?>([
      _service.getCommission(
        year: year,
        month: month,
        search: search,
        storeId: storeId,
        page: page,
        pageSize: 20,
      ),
      if (includeSummary)
        _service.getCommissionSummary(
          year: year,
          month: month,
          search: search,
          storeId: storeId,
        )
      else
        Future.value(null),
    ]).then((responses) {
      final response = responses[0] as CommissionReportResponse;
      final summary = responses[1] as CommissionSummaryDtoModel?;
      return CommissionReportPage(
        entries: response.results.map(_mapEntry).toList(),
        count: response.count,
        hasMore: response.next != null,
        summaryMetrics: summary == null ? [] : _mapSummary(summary),
      );
    });
  }

  CommissionReportEntry _mapEntry(CommissionEntryDtoModel dto) {
    return CommissionReportEntry(
      id: dto.id,
      orderNumber: IdFormatter.formatDisplayId(dto.id),
      customerName:
          '${dto.customerFirstName ?? ''} ${dto.customerLastName ?? ''}'.trim(),
      planName: dto.subPlanDuration == null
          ? dto.planName ?? ''
          : '${dto.planName ?? ''} - ${S.current.monthsCountLabel(dto.subPlanDuration.toString())}',
      saleAmount: dto.orderTotal,
      disbursedAt: DateTimeUtils.parseToLocal(dto.disbursedAt),
      approvedAt: DateTimeUtils.parseToLocal(dto.approvedAt),
    );
  }

  List<ReportSummaryMetric> _mapSummary(CommissionSummaryDtoModel summary) => [
    ReportSummaryMetric(
      label: S.current.commissionSalesAmount,
      value: CurrencyFormatter.format(summary.monthlySalesTotal),
      isCurrency: true,
    ),
    ReportSummaryMetric(
      label: S.current.commissionAmount,
      value: CurrencyFormatter.format(summary.commissionAmountCash),
      isCurrency: true,
    ),
    ReportSummaryMetric(
      label: S.current.commissionRate,
      value:
          '${NumberFormat('0.##', 'en_US').format(summary.commissionRateCash)}٪',
    ),
  ];
}

class CommissionReportPage {
  final List<CommissionReportEntry> entries;
  final List<ReportSummaryMetric> summaryMetrics;
  final int count;
  final bool hasMore;

  const CommissionReportPage({
    required this.entries,
    required this.summaryMetrics,
    required this.count,
    required this.hasMore,
  });
}
