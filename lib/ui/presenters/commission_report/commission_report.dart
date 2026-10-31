import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_divider.dart';
import '../../widget/rtc_search_appbar.dart';
import '../report/widget/report_summary_card.dart';
import 'bloc/commission_report_cubit.dart';
import 'bloc/commission_report_state.dart';
import 'widget/commission_report_filters.dart';
import 'widget/commission_report_results.dart';

class CommissionReportScreen extends StatelessWidget {
  const CommissionReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommissionReportCubit()..init(),
      child: const CommissionReportView(),
    );
  }
}

class CommissionReportView extends StatefulWidget {
  const CommissionReportView({super.key});

  @override
  State<CommissionReportView> createState() => _CommissionReportViewState();
}

class _CommissionReportViewState extends State<CommissionReportView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommissionReportCubit>();
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<CommissionReportCubit, CommissionReportState>(
      builder: (context, state) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.grayPalette.shade50,
        appBar: RtcSearchAppBar(
          isSearchActive: state.isSearchActive,
          title: S.current.commissionReportTitle,
          searchHint: S.current.reportSearchHint,
          onSearchChanged: cubit.onSearchChanged,
          onSearchActivated: cubit.activateSearch,
          onSearchDeactivated: cubit.deactivateSearch,
          scaffoldKey: _scaffoldKey,
          showDrawerIcon: false,
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              // Store, year and month filters
              CommissionReportFilters(state: state),
              // Shared report summary cards
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  itemCount: state.summaryMetrics.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, index) => ReportSummaryCard(
                    metric: state.summaryMetrics[index],
                    width: index == 0 ? 144 : 140,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RtcDivider(
                  height: 1,
                  color: AppColors.grayPalette.shade200,
                ),
              ),
              // Sales list header and filtered count
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Row(
                  children: [
                    Text(
                      S.current.commissionSalesList,
                      style: theme.titleSmall?.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      S.current.resultsCountLabel(state.totalCount),
                      style: theme.bodyMedium?.copyWith(
                        color: AppColors.brandPalette.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CommissionReportResults(
                  key: ValueKey((
                    state.selectedYear,
                    state.selectedMonth,
                    state.searchQuery,
                  )),
                  state: state,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
