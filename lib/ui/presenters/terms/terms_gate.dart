import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'terms_acceptance_sheet.dart';

/// An app-wide, non-dismissible gate; concurrent failures cannot stack sheets.
class TermsGate extends StatefulWidget {
  const TermsGate({super.key, required this.child, required this.onLogout});
  final Widget child;
  final VoidCallback onLogout;
  @override
  State<TermsGate> createState() => _TermsGateState();
}

class _TermsGateState extends State<TermsGate> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() =>
      Future.value(context.read<WorkspaceCubit>().state.termsRequired);
  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkspaceCubit, WorkspaceState>(
    builder: (context, state) => !state.termsRequired
        ? widget.child
        : PopScope(
            canPop: false,
            child: Material(
              color: Colors.white,
              child: SafeArea(
                child: ColoredBox(
                  color: AppColors.grayPalette.shade700.withValues(alpha: .55),
                  child: LayoutBuilder(
                    builder: (context, constraints) => Align(
                      alignment: Alignment.bottomCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: (constraints.maxHeight - 4).clamp(
                            0,
                            double.infinity,
                          ),
                        ),
                        child: TermsAcceptanceSheet(onLogout: widget.onLogout),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
  );
}
