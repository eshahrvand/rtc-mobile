import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_text_button.dart';
import '../bloc/commission_report_cubit.dart';
import '../bloc/commission_report_state.dart';
import 'commission_report_details.dart';
import 'commission_report_item.dart';

class CommissionReportResults extends StatefulWidget {
  final CommissionReportState state;

  const CommissionReportResults({super.key, required this.state});

  @override
  State<CommissionReportResults> createState() =>
      _CommissionReportResultsState();
}

class _CommissionReportResultsState extends State<CommissionReportResults> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.state.paginationErrorMessage.isEmpty &&
        _scrollController.position.extentAfter < 200) {
      context.read<CommissionReportCubit>().fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = context.read<CommissionReportCubit>();
    if (state.status == CommissionReportStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == CommissionReportStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.errorMessage, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              RtcButton(
                title: S.current.retry,
                onPressed: cubit.reload,
                styleBtn: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
    if (state.entries.isEmpty) {
      return Center(child: Text(S.current.noReportFound));
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: state.entries.length + 1,
      itemBuilder: (context, index) {
        if (index == state.entries.length) {
          if (state.isPaginationLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.paginationErrorMessage.isNotEmpty) {
            return Column(
              children: [
                Text(state.paginationErrorMessage, textAlign: TextAlign.center),
                RtcTextButton(
                  title: S.current.retry,
                  onPressed: cubit.fetchNextPage,
                ),
              ],
            );
          }
          if (state.hasMoreData) {
            return Center(
              child: RtcTextButton(
                title: S.current.commissionLoadMore,
                onPressed: cubit.fetchNextPage,
              ),
            );
          }
          return const SizedBox.shrink();
        }
        final entry = state.entries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CommissionReportItem(
            entry: entry,
            onTap: () => CommissionReportDetails.show(context, entry),
          ),
        );
      },
    );
  }
}
