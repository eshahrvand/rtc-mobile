import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/workspace_models.dart';

/// Invoice-local selection; independent of the branch currently being managed.
@immutable
class PreInvoiceBranchState {
  const PreInvoiceBranchState({
    required this.role,
    required this.branches,
    this.selected,
  });
  final AccountRole role;
  final List<BranchInfo> branches;
  final BranchInfo? selected;
  bool get requiresSelection =>
      role == AccountRole.agent && branches.length > 1;
}

class PreInvoiceBranchCubit extends Cubit<PreInvoiceBranchState> {
  PreInvoiceBranchCubit({
    required AccountRole role,
    required List<BranchInfo> branches,
    BranchInfo? assignedBranch,
  }) : super(
         PreInvoiceBranchState(
           role: role,
           branches: List.unmodifiable(branches),
           selected: role == AccountRole.employee
               ? assignedBranch
               : branches.length == 1
               ? branches.single
               : null,
         ),
       );

  void updateBranches(List<BranchInfo> branches) {
    if (state.role != AccountRole.agent) return;
    final selected = branches.where(
      (branch) => branch.id == state.selected?.id,
    );
    emit(
      PreInvoiceBranchState(
        role: state.role,
        branches: List.unmodifiable(branches),
        selected: branches.length == 1 ? branches.single : selected.firstOrNull,
      ),
    );
  }

  void clear() {
    if (state.requiresSelection)
      emit(PreInvoiceBranchState(role: state.role, branches: state.branches));
  }

  void select(String id) {
    if (!state.requiresSelection) return;
    final matches = state.branches.where((branch) => branch.id == id);
    if (matches.isEmpty) return;
    emit(
      PreInvoiceBranchState(
        role: state.role,
        branches: state.branches,
        selected: matches.first,
      ),
    );
  }
}
