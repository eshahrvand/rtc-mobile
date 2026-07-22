import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/report_cubit.dart';
import 'bloc/report_state.dart';
import 'report_step.dart';
import 'widget/report_item_widget.dart';
import 'widget/report_summary_card.dart';
import '../../widget/rtc_search_appbar.dart';
import '../../widget/rtc_chip_list.dart';
import '../../widget/filter_date_bottomsheet.dart';
import '../products/widget/filter_bottom_sheet.dart';
import '../../../core/models/filter_item.dart';
import '../../../core/models/product_chip_model.dart';
import '../../../config/constants.dart';
import '../../theme/colors.dart';
import '../../../generated/l10n.dart';

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

  void _showPlanFilter(BuildContext context, ReportCubit cubit, ReportState state) {
    // TODO: Fetch plans from repository
    final plans = [
      FilterItem(id: '1', title: 'طرح ۱'),
      FilterItem(id: '2', title: 'طرح ۲'),
    ];
    
    FilterBottomSheet.show(
      context,
      title: 'انتخاب طرح',
      subtitle: 'طرح مورد نظر را انتخاب کنید',
      items: plans,
      initialSelectedId: state.selectedPlanId,
      onApply: (selected) => cubit.onPlanSelected(selected?.id),
      onClear: () => cubit.onPlanSelected(null),
    );
  }

  void _showCategoryFilter(BuildContext context, ReportCubit cubit, ReportState state, bool isParent) {
    // TODO: Fetch categories from repository
    final categories = [
      FilterItem(id: 'c1', title: 'دسته‌بندی ۱'),
      FilterItem(id: 'c2', title: 'دسته‌بندی ۲'),
    ];
    
    FilterBottomSheet.show(
      context,
      title: isParent ? 'دسته‌بندی والد' : 'دسته‌بندی کالا',
      subtitle: 'دسته‌بندی مورد نظر را انتخاب کنید',
      items: categories,
      initialSelectedId: isParent ? state.selectedParentCategoryId : state.selectedCategoryId,
      onApply: (selected) => isParent 
          ? cubit.onParentCategorySelected(selected?.id) 
          : cubit.onCategorySelected(selected?.id),
      onClear: () => isParent 
          ? cubit.onParentCategorySelected(null) 
          : cubit.onCategorySelected(null),
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
    return BlocProvider(
      create: (context) => ReportCubit()..init(widget.initialStep),
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          final cubit = context.read<ReportCubit>();
          
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color(0xFFFAFAFA),
            appBar: RtcSearchAppBar(
              isSearchActive: state.isSearchActive,
              title: state.step.title,
              onSearchChanged: cubit.onSearchChanged,
              onSearchActivated: cubit.activateSearch,
              onSearchDeactivated: cubit.deactivateSearch,
              scaffoldKey: _scaffoldKey,
              searchHint: 'جستجو در گزارش...',
            ),
            body: Column(
              children: [
                _buildFilterRow(context, cubit, state),
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
    
    return chips.reversed.toList(); // Align with right-to-left layout as per HTML
  }

  Widget _buildSummaryMetrics(ReportState state) {
    if (state.summaryMetrics.isEmpty) return const SizedBox.shrink();
    
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        reverse: true, // Right-to-left alignment
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
          '${state.filteredItems.length} نتیجه',
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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: state.filteredItems.length,
      itemBuilder: (context, index) {
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
