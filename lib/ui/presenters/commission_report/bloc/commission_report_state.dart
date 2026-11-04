import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/commission_report_entry.dart';
import '../../../../core/models/report_item_model.dart';

part 'commission_report_state.freezed.dart';

enum CommissionReportStatus { initial, loading, success, error }

@freezed
class CommissionReportState with _$CommissionReportState {
  const factory CommissionReportState({
    @Default([]) List<CommissionReportEntry> entries,
    @Default(CommissionReportStatus.initial) CommissionReportStatus status,
    @Default('') String errorMessage,
    @Default([]) List<ReportSummaryMetric> summaryMetrics,
    @Default([]) List<int> years,
    int? selectedYear,
    int? selectedMonth,
    @Default('') String searchQuery,
    @Default(false) bool isSearchActive,
    @Default(1) int currentPage,
    @Default(0) int totalCount,
    @Default(false) bool hasMoreData,
    @Default(false) bool isPaginationLoading,
    @Default('') String paginationErrorMessage,
  }) = _CommissionReportState;
}
