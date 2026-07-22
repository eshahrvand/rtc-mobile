import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../core/models/report_item_model.dart';
import '../report_step.dart';

part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState({
    @Default(ReportStep.sales) ReportStep step,
    @Default(ReportRequestStatus.initial) ReportRequestStatus status,
    @Default([]) List<ReportItemModel> items,
    @Default([]) List<ReportItemModel> filteredItems,
    @Default([]) List<ReportSummaryMetric> summaryMetrics,
    @Default('') String searchQuery,
    @Default(false) bool isSearchActive,
    @Default('') String errorMessage,
    
    // Filters
    String? selectedPlanId,
    String? selectedCategoryId,
    String? selectedParentCategoryId,
    Jalali? startDate,
    Jalali? endDate,
    String? dateOptionId,
    
    // Pagination (placeholders for future)
    @Default(1) int currentPage,
    @Default(false) bool isPaginationLoading,
  }) = _ReportState;
}

enum ReportRequestStatus {
  initial,
  loading,
  success,
  error,
}
