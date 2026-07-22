import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/report_cubit.dart';
import 'bloc/report_state.dart';
import 'bloc/report_step.dart';
import 'widget/report_item_widget.dart';
import 'widget/report_summary_card.dart';
import '../../widget/rtc_search_appbar.dart';
import '../../widget/rtc_chip_list.dart';
import '../../widget/filter_date_bottomsheet.dart';
import '../products/widget/filter_bottom_sheet.dart';
import '../../../core/models/filter_item.dart';
import '../../../core/models/product_chip_model.dart';
import '../../theme/colors.dart';

class ReportScreen extends StatefulWidget {
  final ReportStep initialStep;

  const ReportScreen({
    super.key,
    required this.initialStep,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  late final ReportCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ReportCubit()..init(widget.initialStep);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _cubit.fetchNextPage();
    }
  }

  void _showPlanFilter(BuildContext context, ReportCubit cubit, ReportState state) {
    FilterBottomSheet.show<ReportCubit, ReportState>(
      context,
      bloc: cubit,
      title: 'انتخاب طرح',
      subtitle: 'طرح مورد نظر را انتخاب کنید',
      items: state.subPlans.map((e) => FilterItem(id: e.id, title: e.name)).toList(),
      itemsSelector: (s) => s.subPlans.map((e) => FilterItem(id: e.id, title: e.name)).toList(),
      loadingSelector: (s) => s.isSubPlanPaginationLoading,
      initialSelectedId: state.selectedPlanId,
      onApply: (selected) => cubit.onPlanSelected(selected?.id),
      onClear: () => cubit.onPlanSelected(null),
      onLoadMore: cubit.fetchSubPlansNextPage,
    );
  }

  void _showCategoryFilter(BuildContext context, ReportCubit cubit, ReportState state, bool isParent) {
    FilterBottomSheet.show<ReportCubit, ReportState>(
      context,
      bloc: cubit,
      title: isParent ? 'دسته‌بندی والد' : 'دسته‌بندی کالا',
      subtitle: 'دسته‌بندی مورد نظر را انتخاب کنید',
      items: state.categories.map((e) => FilterItem(id: e.id, title: e.name)).toList(),
      itemsSelector: (s) => s.categories.map((e) => FilterItem(id: e.id, title: e.name)).toList(),
      loadingSelector: (s) => s.isCategoryPaginationLoading,
      initialSelectedId: isParent ? state.selectedParentCategoryId : state.selectedCategoryId,
      onApply: (selected) => isParent 
          ? cubit.onParentCategorySelected(selected?.id) 
          : cubit.onCategorySelected(selected?.id),
      onClear: () => isParent 
          ? cubit.onParentCategorySelected(null) 
          : cubit.onCategorySelected(null),
      onLoadMore: cubit.fetchCategoriesNextPage,
    );
  }

  void _showDateFilter(BuildContext context, ReportCubit cubit, ReportState state) {
    FilterDateBottomSheet.show(
      context,
      initialStartDate: state.startDate,
      initialEndDate: state.endDate,
      initialOptionId: state.dateOptionId,
      onApply: cubit.onDateFilterApplied,
      onClear: cubit.onClearFilters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color(0xFFFAFAFA),
            appBar: RtcSearchAppBar(
              isSearchActive: state.isSearchActive,
              title: state.step.title,
              onSearchChanged: _cubit.onSearchChanged,
              onSearchActivated: _cubit.activateSearch,
              onSearchDeactivated: _cubit.deactivateSearch,
              scaffoldKey: _scaffoldKey,
              searchHint: 'جستجو در گزارش...',
              showDrawerIcon: false,
            ),
            body: Column(
              children: [
                _buildFilterRow(context, _cubit, state),
                _buildSummaryMetrics(state),
                _buildResultsLabel(state),
                Expanded(
                  child: state.status == ReportRequestStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.status == ReportRequestStatus.error
                          ? Center(child: Text(state.errorMessage))
                          : _buildReportList(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, ReportCubit cubit, ReportState state) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: RtcChipList(
              chips: _getFilterChips(state.step),
              isChipSelected: (index, chip) {
                if (chip.id == 1) return state.selectedPlanId != null;
                if (chip.id == 2) return state.selectedCategoryId != null;
                if (chip.id == 3) return state.selectedParentCategoryId != null;
                if (chip.id == 4) return state.dateOptionId != null || state.startDate != null;
                return false;
              },
              onChipTap: (index, chip) {
                if (chip.id == 1) _showPlanFilter(context, cubit, state);
                if (chip.id == 2) _showCategoryFilter(context, cubit, state, false);
                if (chip.id == 3) _showCategoryFilter(context, cubit, state, true);
                if (chip.id == 4) _showDateFilter(context, cubit, state);
              },
              onChipClose: (index, chip) => _cubit.onChipClose(chip),
            ),
          ),
        ],
      ),
    );
  }

  List<ProductChipModel> _getFilterChips(ReportStep step) {
    final chips = <ProductChipModel>[];
    
    // Date filter is common for all
    chips.add(ProductChipModel(id: 4, label: 'تاریخ', opensBottomSheet: true));
    
    switch (step) {
      case ReportStep.sales:
      case ReportStep.plan:
      case ReportStep.products:
        chips.add(ProductChipModel(id: 1, label: 'طرح', opensBottomSheet: true));
        break;
      default:
        break;
    }
    
    if (step == ReportStep.category || step == ReportStep.products) {
      chips.add(ProductChipModel(id: 3, label: 'دسته‌بندی والد', opensBottomSheet: true));
    }
    
    return chips.reversed.toList(); 
  }

  Widget _buildSummaryMetrics(ReportState state) {
    if (state.summaryMetrics.isEmpty) return const SizedBox.shrink();
    
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        reverse: true, 
        itemCount: state.summaryMetrics.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ReportSummaryCard(metric: state.summaryMetrics[index]),
          );
        },
      ),
    );
  }

  Widget _buildResultsLabel(ReportState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '${state.totalCount} نتیجه',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.brandPalette.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildReportList(ReportState state) {
    if (state.filteredItems.isEmpty) {
      return const Center(child: Text('گزارشی یافت نشد'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: state.filteredItems.length + (state.hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.filteredItems.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return ReportItemWidget(
          item: state.filteredItems[index],
          step: state.step,
          onTap: () {
            // TODO: Open bottom sheet detail
          },
        );
      },
    );
  }
}
