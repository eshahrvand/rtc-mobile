import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_selection_field.dart';
import '../../../../core/models/filter_item.dart';
import '../../products/widget/filter_bottom_sheet.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_branch_cubit.dart';

class PreInvoiceBranchView extends StatelessWidget {
  const PreInvoiceBranchView({super.key});

  @override
  Widget build(BuildContext context) {
    final selection = context.read<PreInvoiceCubit>().branchSelection;
    return BlocBuilder<PreInvoiceBranchCubit, PreInvoiceBranchState>(
      bloc: selection,
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                S.current.selectInvoiceBranchPrompt,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.workspaceTextStrong,
                  height: 24 / 14,
                ),
              ),
              const SizedBox(height: 12),
              RtcSelectionField(
                hint: S.current.selectInvoiceBranchHint,
                value: state.selected?.name,
                onTap: () {
                  final current = selection.state;
                  FilterBottomSheet.show(
                    context,
                    showClearAction: false,
                    applyButtonTitle: S.current.confirm,
                    title: S.current.selectInvoiceBranch,
                    subtitle: S.current.selectInvoiceBranchPrompt,
                    items: current.branches
                        .map(
                          (branch) =>
                              FilterItem(id: branch.id, title: branch.name),
                        )
                        .toList(),
                    initialSelectedId: current.selected?.id,
                    onApply: (item) {
                      if (item != null) selection.select(item.id);
                    },
                    onClear: selection.clear,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
