import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../locator.dart';
import '../../../../repository/report/report_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../config/errorhandler.dart';
import 'report_state.dart';
import 'report_step.dart';

class ReportCubit extends Cubit<ReportState> {
  final _reportRepo = sl<ReportRepository>();
  final _plansRepo = sl<PlansRepository>();
  final _productRepo = sl<ProductRepository>();

  Timer? _searchTimer;

  ReportCubit() : super(const ReportState());

  void init(ReportStep step) {
    emit(state.copyWith(step: step, status: ReportRequestStatus.loading));
    
    // Fetch filter data in parallel
    Future.wait([
      _plansRepo.getSubPlans(page: 1),
      _productRepo.getCategories(page: 1),
    ]).then((values) {
      final subPlansResponse = values[0] as dynamic;
      final categoriesResponse = values[1] as dynamic;
      
      emit(state.copyWith(
        subPlans: subPlansResponse.results,
        hasMoreSubPlans: subPlansResponse.next != null,
        currentSubPlanPage: 1,
        categories: categoriesResponse.results,
        hasMoreCategories: categoriesResponse.next != null,
        currentCategoryPage: 1,
      ));
    }).catchError((_) {});

    _fetchData(step);
  }

  void fetchCategoriesNextPage() {
    if (state.isCategoryPaginationLoading || !state.hasMoreCategories) return;

    emit(state.copyWith(isCategoryPaginationLoading: true));

    final nextPage = state.currentCategoryPage + 1;

    _productRepo
        .getCategories(page: nextPage)
        .then((response) {
          emit(
            state.copyWith(
              isCategoryPaginationLoading: false,
              currentCategoryPage: nextPage,
              categories: [...state.categories, ...response.results],
              hasMoreCategories: response.next != null,
            ),
          );
        })
        .catchError((e) {
          emit(state.copyWith(isCategoryPaginationLoading: false));
          return null;
        });
  }

  void fetchSubPlansNextPage() {
    if (state.isSubPlanPaginationLoading || !state.hasMoreSubPlans) return;

    emit(state.copyWith(isSubPlanPaginationLoading: true));

    final nextPage = state.currentSubPlanPage + 1;

    _plansRepo
        .getSubPlans(page: nextPage)
        .then((response) {
          emit(
            state.copyWith(
              isSubPlanPaginationLoading: false,
              currentSubPlanPage: nextPage,
              subPlans: [...state.subPlans, ...response.results],
              hasMoreSubPlans: response.next != null,
            ),
          );
        })
        .catchError((e) {
          emit(state.copyWith(isSubPlanPaginationLoading: false));
          return null;
        });
  }

  void _fetchData(ReportStep step) {
    emit(state.copyWith(
      status: ReportRequestStatus.loading,
      currentPage: 1,
      hasMoreData: true,
      items: [],
      filteredItems: [],
    ));

    final dateFrom = _formatGregorianDate(state.startDate);
    final dateTo = _formatGregorianDate(state.endDate);

    _getReportFuture(step, page: 1, dateFrom: dateFrom, dateTo: dateTo)
        .then((bundle) {
          final items = _reportRepo.mapToDomain(bundle.response, step);
          final metrics = _reportRepo.mapSummaryToDomain(bundle.summary, step);
          
          emit(state.copyWith(
            status: ReportRequestStatus.success,
            items: items,
            filteredItems: items,
            summaryMetrics: metrics,
            totalCount: (bundle.response as dynamic).count,
            hasMoreData: (bundle.response as dynamic).next != null,
          ));
        })
        .catchError((error) {
          emit(state.copyWith(
            status: ReportRequestStatus.error,
            errorMessage: ErrorHandler.getMessage(error),
          ));
        });
  }

  void fetchNextPage() {
    if (state.isPaginationLoading || !state.hasMoreData || state.status == ReportRequestStatus.loading) {
      return;
    }

    emit(state.copyWith(isPaginationLoading: true));

    final nextPage = state.currentPage + 1;
    final dateFrom = _formatGregorianDate(state.startDate);
    final dateTo = _formatGregorianDate(state.endDate);

    _getReportFuture(state.step, page: nextPage, dateFrom: dateFrom, dateTo: dateTo, includeSummary: false)
        .then((bundle) {
          final newItems = _reportRepo.mapToDomain(bundle.response, state.step);
          final updatedItems = [...state.items, ...newItems];

          emit(state.copyWith(
            isPaginationLoading: false,
            currentPage: nextPage,
            items: updatedItems,
            filteredItems: updatedItems,
            hasMoreData: (bundle.response as dynamic).next != null,
          ));
        })
        .catchError((error) {
          emit(state.copyWith(isPaginationLoading: false));
        });
  }

  Future<ReportDataBundle> _getReportFuture(
    ReportStep step, {
    int? page,
    String? dateFrom,
    String? dateTo,
    bool includeSummary = true,
  }) {
    switch (step) {
      case ReportStep.sales:
        return _reportRepo.getSalesOverview(
          dateFrom: dateFrom,
          dateTo: dateTo,
          subPlanId: state.selectedPlanId,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
          page: page,
          includeSummary: includeSummary,
        );
      case ReportStep.plan:
        return _reportRepo.getSalesByPlan(
          dateFrom: dateFrom,
          dateTo: dateTo,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
          page: page,
          includeSummary: includeSummary,
        );
      case ReportStep.category:
        return _reportRepo.getSalesByCategory(
          dateFrom: dateFrom,
          dateTo: dateTo,
          parentCategoryId: state.selectedParentCategoryId,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
          page: page,
          includeSummary: includeSummary,
        );
      case ReportStep.products:
        return _reportRepo.getSalesByProduct(
          dateFrom: dateFrom,
          dateTo: dateTo,
          categoryId: state.selectedCategoryId,
          subPlanId: state.selectedPlanId,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
          page: page,
          includeSummary: includeSummary,
        );
    }
  }

  void onChipClose(ProductChipModel chip) {
    if (chip.id == 1) onPlanSelected(null);
    if (chip.id == 2) onCategorySelected(null);
    if (chip.id == 3) onParentCategorySelected(null);
    if (chip.id == 4) onClearFilters(); // For date
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));

    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(seconds: 1), () {
      _fetchData(state.step);
    });
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    _searchTimer?.cancel();
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    _fetchData(state.step);
  }

  void onPlanSelected(String? id) {
    emit(state.copyWith(selectedPlanId: id));
    _fetchData(state.step);
  }

  void onCategorySelected(String? id) {
    emit(state.copyWith(selectedCategoryId: id));
    _fetchData(state.step);
  }

  void onParentCategorySelected(String? id) {
    emit(state.copyWith(selectedParentCategoryId: id));
    _fetchData(state.step);
  }

  void onDateFilterApplied(Jalali? start, Jalali? end, String? optionId) {
    emit(state.copyWith(
      startDate: start,
      endDate: end,
      dateOptionId: optionId,
    ));
    _fetchData(state.step);
  }

  void onClearFilters() {
    emit(state.copyWith(
      selectedPlanId: null,
      selectedCategoryId: null,
      selectedParentCategoryId: null,
      startDate: null,
      endDate: null,
      dateOptionId: null,
    ));
    _fetchData(state.step);
  }

  String? _formatGregorianDate(Jalali? date) {
    if (date == null) return null;
    final dateTime = date.toDateTime();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
