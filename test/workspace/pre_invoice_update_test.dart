import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/pre_invoice_model.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/main_ui_preview.dart';
import 'package:rtc_mobile/ui/preview/workspace_preview_data.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/bloc/pre_invoice_branch_cubit.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/bloc/pre_invoice_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final branches = WorkspacePreviewData.branches;

  test('branch selection is role-dependent and rejects foreign IDs', () async {
    final agent = PreInvoiceBranchCubit(
      role: AccountRole.agent,
      branches: branches,
    );
    expect(agent.state.requiresSelection, isTrue);
    expect(agent.state.selected, isNull);
    agent.select('unknown');
    expect(agent.state.selected, isNull);
    agent.select(branches.last.id);
    expect(agent.state.selected, branches.last);
    final employee = PreInvoiceBranchCubit(
      role: AccountRole.employee,
      branches: branches,
      assignedBranch: branches.first,
    );
    expect(employee.state.requiresSelection, isFalse);
    employee.select(branches.last.id);
    expect(employee.state.selected, branches.first);
    final single = PreInvoiceBranchCubit(
      role: AccountRole.agent,
      branches: [branches.first],
    );
    expect(single.state.requiresSelection, isFalse);
    expect(single.state.selected, branches.first);
    await agent.close();
    await employee.close();
    await single.close();
  });

  test(
    'branch navigation cannot continue without a selection and retains it on back',
    () async {
      await sl.reset();
      await initializeUiPreview();
      final cubit = PreInvoiceCubit(
        role: AccountRole.agent,
        branches: branches,
      );
      expect(cubit.state.currentStep, PreInvoiceStep.branch);
      expect(cubit.steps.length, 6);
      expect(cubit.canContinue, isFalse);
      cubit.goToStep(PreInvoiceStep.creditPlan);
      expect(cubit.state.currentStep, PreInvoiceStep.branch);
      cubit.branchSelection.select(branches.first.id);
      expect(cubit.canContinue, isTrue);
      cubit.goToStep(PreInvoiceStep.creditPlan);
      expect(cubit.isFirstStep, isFalse);
      cubit.previousStep();
      expect(cubit.state.currentStep, PreInvoiceStep.branch);
      expect(cubit.branchSelection.state.selected, branches.first);
      await cubit.close();
      for (final role in AccountRole.values) {
        final flow = PreInvoiceCubit(
          role: role,
          branches: role == AccountRole.agent ? [branches.first] : branches,
        );
        expect(flow.steps.length, 5);
        expect(flow.state.currentStep, PreInvoiceStep.creditPlan);
        expect(flow.isFirstStep, isTrue);
        flow.goToStep(PreInvoiceStep.branch);
        expect(flow.state.currentStep, PreInvoiceStep.creditPlan);
        await flow.close();
      }
      await sl.reset();
    },
  );

  CartItemModel item({num? consumerPrice, int quantity = 1}) => CartItemModel(
    productId: 'p',
    name: 'product',
    imageUrl: '',
    price: '100',
    quantity: quantity,
    consumerUnitPrice: consumerPrice,
  );

  test(
    'consumer total uses independent prices and quantities; missing prices remain unknown',
    () {
      final state = PreInvoiceState(
        cartItems: [
          item(consumerPrice: 1500, quantity: 2),
          item(consumerPrice: 500),
        ],
        payableAmount: '300',
      );
      expect(state.consumerFinalAmount, '3,500');
      expect(state.payableAmount, '300');
      expect(
        state
            .copyWith(cartItems: [state.cartItems.first.copyWith(quantity: 3)])
            .consumerFinalAmount,
        '4,500',
      );
      expect(state.copyWith(cartItems: [item()]).consumerFinalAmount, isNull);
      expect(const PreInvoiceState().consumerFinalAmount, isNull);
      expect(
        state.copyWith(cartItems: [item(consumerPrice: 0)]).consumerFinalAmount,
        '0',
      );
    },
  );
}
