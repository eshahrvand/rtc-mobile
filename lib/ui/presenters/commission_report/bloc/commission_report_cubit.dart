import '../../../../core/bloc/mounted_cubit.dart';
import 'dart:async';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../config/errorhandler.dart';
import '../../../../locator.dart';
import '../../../../repository/report/commission_report_repository.dart';
import '../../../../repository/workspace/workspace_repository.dart';
import '../../../../core/models/workspace_models.dart';
import '../../../../generated/l10n.dart';
import 'commission_report_state.dart';

class CommissionReportCubit extends MountedCubit<CommissionReportState> {
  CommissionReportCubit() : super(const CommissionReportState());

  final _repository = sl<CommissionReportRepository>();
  Timer? _searchTimer;
  int _requestId = 0;

  void init() {
    final today = Jalali.now();
    emit(
      state.copyWith(
        years: List.generate(today.year - 1300 + 1, (index) => 1300 + index),
      ),
    );
    reload();
  }

  void activateSearch() => emit(state.copyWith(isSearchActive: true));

  void deactivateSearch() {
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    reload();
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _reload(debounce: query.trim().isNotEmpty);
  }

  void selectYear(int? year) {
    emit(state.copyWith(selectedYear: year));
    reload();
  }

  void selectMonth(int? month) {
    emit(state.copyWith(selectedMonth: month));
    reload();
  }

  void selectStore(String? id) {
    if (state.selectedStoreId == id) return;
    emit(state.copyWith(selectedStoreId: id));
    reload();
  }

  void loadStores() {
    if (state.isStoreOptionsLoading) return;
    emit(state.copyWith(isStoreOptionsLoading: true, storeOptionsError: ''));
    final workspace = sl<WorkspaceRepository>();
    (workspace.loadBranches?.call() ??
            workspace.unavailable<List<BranchInfo>>())
        .then((stores) {
          if (!isClosed) {
            emit(
              state.copyWith(
                storeOptions: stores,
                isStoreOptionsLoading: false,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (!isClosed) {
            emit(
              state.copyWith(
                isStoreOptionsLoading: false,
                storeOptionsError: error is WorkspaceServicePending
                    ? S.current.workspaceServicePending
                    : ErrorHandler.getMessage(error),
              ),
            );
          }
        });
  }

  void reload() => _reload();

  void _reload({bool debounce = false}) {
    _searchTimer?.cancel();
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        status: CommissionReportStatus.loading,
        entries: [],
        summaryMetrics: [],
        errorMessage: '',
        paginationErrorMessage: '',
        currentPage: 1,
        totalCount: 0,
        hasMoreData: false,
        isPaginationLoading: false,
      ),
    );
    if (debounce) {
      _searchTimer = Timer(
        const Duration(milliseconds: 400),
        () => _fetchReport(requestId),
      );
    } else {
      _fetchReport(requestId);
    }
  }

  void _fetchReport(int requestId) {
    final query = state.searchQuery.trim();
    _repository
        .getReport(
          year: state.selectedYear,
          month: state.selectedMonth,
          storeId: state.selectedStoreId,
          search: query.isEmpty ? null : query,
        )
        .then((page) {
          if (isClosed || requestId != _requestId) return;
          emit(
            state.copyWith(
              status: CommissionReportStatus.success,
              entries: page.entries,
              summaryMetrics: page.summaryMetrics,
              totalCount: page.count,
              hasMoreData: page.hasMore,
            ),
          );
        })
        .catchError((Object error) {
          if (isClosed || requestId != _requestId) return;
          emit(
            state.copyWith(
              status: CommissionReportStatus.error,
              errorMessage: ErrorHandler.getMessage(error),
            ),
          );
        });
  }

  void fetchNextPage() {
    if (state.status != CommissionReportStatus.success ||
        state.isPaginationLoading ||
        !state.hasMoreData) {
      return;
    }
    final requestId = _requestId;
    final nextPage = state.currentPage + 1;
    final query = state.searchQuery.trim();
    emit(state.copyWith(isPaginationLoading: true, paginationErrorMessage: ''));
    _repository
        .getReport(
          year: state.selectedYear,
          month: state.selectedMonth,
          storeId: state.selectedStoreId,
          search: query.isEmpty ? null : query,
          page: nextPage,
          includeSummary: false,
        )
        .then((page) {
          if (isClosed || requestId != _requestId) return;
          emit(
            state.copyWith(
              entries: [...state.entries, ...page.entries],
              currentPage: nextPage,
              totalCount: page.count,
              hasMoreData: page.hasMore,
              isPaginationLoading: false,
            ),
          );
        })
        .catchError((Object error) {
          if (isClosed || requestId != _requestId) return;
          emit(
            state.copyWith(
              isPaginationLoading: false,
              paginationErrorMessage: ErrorHandler.getMessage(error),
            ),
          );
        });
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
