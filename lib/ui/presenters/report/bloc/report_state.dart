import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../data_source/remote/plans/model/plan_dto_model.dart';
import '../../../../data_source/remote/catalog/model/category_dto_model.dart';
import 'report_step.dart';

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

    // Filter Data
    @Default([]) List<SubPlanDtoModel> subPlans,
    @Default([]) List<CategoryDtoModel> categories,

    // Filter Pagination
    @Default(1) int currentCategoryPage,
    @Default(false) bool hasMoreCategories,
    @Default(false) bool isCategoryPaginationLoading,
    @Default(1) int currentSubPlanPage,
    @Default(false) bool hasMoreSubPlans,
    @Default(false) bool isSubPlanPaginationLoading,

    // Pagination
    @Default(1) int currentPage,
    @Default(0) int totalCount,
    @Default(false) bool hasMoreData,
    @Default(false) bool isPaginationLoading,
  }) = _ReportState;
}

enum ReportRequestStatus { initial, loading, success, error }
