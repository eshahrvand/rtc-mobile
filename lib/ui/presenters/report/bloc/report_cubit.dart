import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'report_state.dart';
import '../report_step.dart';
import '../../../../core/models/report_item_model.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(const ReportState());

  void init(ReportStep step) {
    emit(state.copyWith(step: step, status: ReportRequestStatus.loading));
    _fetchData(step);
  }

  void _fetchData(ReportStep step) {
    // TODO: Connect to repository
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      final mockItems = _generateMockData(step);
      final mockMetrics = _generateMockMetrics(step);
      emit(state.copyWith(
        status: ReportRequestStatus.success,
        items: mockItems,
        filteredItems: mockItems,
        summaryMetrics: mockMetrics,
      ));
    }).catchError((error) {
      emit(state.copyWith(
        status: ReportRequestStatus.error,
        errorMessage: error.toString(),
      ));
    });
  }

  void onSearchChanged(String query) {
    final filtered = state.items.where((item) {
      return item.title.contains(query) ||
          (item.subtitle?.contains(query) ?? false) ||
          (item.sku?.contains(query) ?? false);
    }).toList();

    emit(state.copyWith(
      searchQuery: query,
      filteredItems: filtered,
    ));
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    emit(state.copyWith(
      isSearchActive: false,
      searchQuery: '',
      filteredItems: state.items,
    ));
  }

  // Filter handlers
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

  List<ReportSummaryMetric> _generateMockMetrics(ReportStep step) {
    switch (step) {
      case ReportStep.sales:
        return [
          const ReportSummaryMetric(label: 'مبلغ کل فروش', value: '۲۰۰۰۰۰۰۰۰۰', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد کل سفارشات', value: '۱۳۰'),
          const ReportSummaryMetric(label: 'میانگین مبلغ فروش', value: '۱۵۳۸۴۶۱۵', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد اقلام', value: '۱۵۰'),
          const ReportSummaryMetric(label: 'میانگین تعداد کالا در هر سفارش', value: '۵'),
          const ReportSummaryMetric(label: 'مشتریان منحصر به فرد', value: '۱۰۲'),
        ];
      case ReportStep.plan:
        return [
          const ReportSummaryMetric(label: 'مبلغ کل خرید', value: '۲۰۰۰۰۰۰۰۰۰', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد کل سفارشات', value: '۱۳۰'),
          const ReportSummaryMetric(label: 'میانگین فروش هر طرح', value: '۱۵۳۸۴۶۱۵', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد کل اقلام', value: '۱۵۰'),
        ];
      case ReportStep.category:
        return [
          const ReportSummaryMetric(label: 'کل مبلغ فروش', value: '۲۰۰۰۰۰۰۰۰۰', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد کل سفارشات', value: '۱۳۰'),
          const ReportSummaryMetric(label: 'تعداد کل اقلام', value: '۱۴'),
        ];
      case ReportStep.products:
        return [
          const ReportSummaryMetric(label: 'جمع کل مبلغ فروش', value: '۲۰۰۰۰۰۰۰۰۰', isCurrency: true),
          const ReportSummaryMetric(label: 'تعداد کل سفارشات', value: '۱۳۰'),
          const ReportSummaryMetric(label: 'تعداد کل اقلام', value: '۱۵۰'),
        ];
    }
  }

  List<ReportItemModel> _generateMockData(ReportStep step) {
    switch (step) {
      case ReportStep.sales:
        return List.generate(5, (index) => ReportItemModel(
          id: 'PF-1404-00125',
          title: 'PF-1404-00125',
          quantity: '۳',
          tagLabel: 'آپ - ۱۲ ماهه',
          amount: '80200000',
          date: '۱۴۰۵/۰۱/۲۵',
          time: '۱۲:۱۵',
        ));
      case ReportStep.plan:
        return List.generate(5, (index) => const ReportItemModel(
          id: 'plan_1',
          title: 'اسنپ پی',
          tagLabel: 'اسنپ‌پی - ۶ ماهه',
          secondaryLabel: 'نام زیر مجموعه',
          quantity: '۴',
          amount: '80200000',
        ));
      case ReportStep.category:
        return List.generate(5, (index) => const ReportItemModel(
          id: 'cat_1',
          title: 'تلویزیون',
          tagLabel: 'لوازم صوتی تصویری',
          secondaryLabel: 'دسته ‌والد',
          quantity: '۴',
          amount: '80200000',
        ));
      case ReportStep.products:
        return List.generate(5, (index) => const ReportItemModel(
          id: 'prod_1',
          title: 'X500',
          sku: 'RTC-REF-001',
          tagLabel: 'لوازم صوتی تصویری',
          secondaryLabel: 'دسته بندی کالا',
          amount: '80200000',
          secondaryAmount: '80200000',
          quantity: '۴',
        ));
    }
  }
}
