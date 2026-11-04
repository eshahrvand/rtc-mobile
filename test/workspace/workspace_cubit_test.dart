import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/data_source/local/prefs/prefs.dart';
import 'package:rtc_mobile/data_source/remote/service_util.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_state.dart';
import 'package:rtc_mobile/ui/presenters/branches/employee_form_cubit.dart';

const terms = TermsDocument(
  version: '3',
  versionLabel: 'نسخه ۳',
  markdown: '# قوانین',
  publishedAt: '۱۴۰۵/۰۸/۰۵',
);
const branchA = BranchInfo(
  id: 'a',
  name: 'تهران',
  province: 'تهران',
  city: 'تهران',
  postalCode: '',
  address: '',
);
const branchB = BranchInfo(
  id: 'b',
  name: 'مشهد',
  province: 'خراسان رضوی',
  city: 'مشهد',
  postalCode: '',
  address: '',
);
const employee = BranchEmployee(
  id: '1',
  branchId: 'a',
  firstName: 'علی',
  lastName: 'موسوی',
  nationalId: '0081234562',
  mobile: '09121234325',
  position: 'حسابدار',
);
Future<void> tick() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => S.load(const Locale('fa')));

  test(
    'employees cannot accept terms or mutate branches, even if called directly',
    () async {
      var accepts = 0, saves = 0;
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          acceptTerms: (_) {
            accepts++;
            return Future.value(terms);
          },
          saveEmployee: (employee) {
            saves++;
            return Future.value(employee);
          },
        ),
        initialState: const WorkspaceState(
          role: AccountRole.employee,
          terms: terms,
        ),
      );
      addTearDown(cubit.close);
      cubit.requireTerms(document: terms);
      cubit.checkAgreement(true);
      cubit.confirmTerms();
      cubit.selectBranch(branchA);
      cubit.saveEmployee(employee);
      await tick();
      expect(accepts, 0);
      expect(saves, 0);
      expect(cubit.state.termsRequired, isTrue);
      expect(cubit.state.selectedBranch, isNull);
    },
  );

  test(
    'agent gate remains blocked until the chosen version is confirmed',
    () async {
      final acceptance = Completer<TermsDocument>();
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          acceptTerms: (version) {
            expect(version, '3');
            return acceptance.future;
          },
        ),
      );
      addTearDown(cubit.close);
      cubit.requireTerms(document: terms);
      cubit.confirmTerms();
      expect(cubit.state.termsStatus, WorkspaceStatus.initial);
      cubit.checkAgreement(true);
      cubit.confirmTerms();
      expect(cubit.state.termsRequired, isTrue);
      expect(cubit.state.termsStatus, WorkspaceStatus.loading);
      acceptance.complete(terms);
      await tick();
      expect(cubit.state.termsRequired, isFalse);
    },
  );

  test('a newer terms version invalidates the old confirmation', () async {
    final acceptance = Completer<TermsDocument>();
    final cubit = WorkspaceCubit(
      WorkspaceRepository(acceptTerms: (_) => acceptance.future),
    );
    addTearDown(cubit.close);
    cubit.requireTerms(document: terms);
    cubit.checkAgreement(true);
    cubit.confirmTerms();
    cubit.requireTerms(
      document: const TermsDocument(
        version: '4',
        versionLabel: '۴',
        markdown: '# قوانین جدید',
        publishedAt: '',
      ),
    );
    acceptance.complete(terms);
    await tick();
    expect(cubit.state.termsRequired, isTrue);
    expect(cubit.state.terms!.version, '4');
    expect(cubit.state.termsChecked, isFalse);
  });

  test('logout ignores a late employee recheck response', () async {
    final check = Completer<bool>();
    final cubit = WorkspaceCubit(
      WorkspaceRepository(checkTerms: () => check.future),
      initialState: const WorkspaceState(
        role: AccountRole.employee,
        termsRequired: true,
      ),
    );
    addTearDown(cubit.close);
    cubit.recheckTerms();
    cubit.reset();
    check.complete(false);
    await tick();
    expect(cubit.state.termsRequired, isFalse);
    expect(cubit.state.termsStatus, WorkspaceStatus.initial);
  });

  test(
    'branch responses cannot replace employees of a subsequently selected branch',
    () async {
      final a = Completer<List<BranchEmployee>>(),
          b = Completer<List<BranchEmployee>>();
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          loadEmployees: (id) => id == 'a' ? a.future : b.future,
        ),
      );
      addTearDown(cubit.close);
      cubit.selectBranch(branchA);
      cubit.selectBranch(branchB);
      b.complete([]);
      await tick();
      a.complete([employee]);
      await tick();
      expect(cubit.state.selectedBranch!.id, 'b');
      expect(cubit.state.employees, isEmpty);
    },
  );

  test(
    'refund submission is deduplicated, failures remain retryable, success survives navigation state',
    () async {
      var calls = 0;
      var response = Completer<void>();
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          submitRefund: (_) {
            calls++;
            return response.future;
          },
        ),
      );
      addTearDown(cubit.close);
      cubit.requestRefund('a');
      cubit.requestRefund('a');
      expect(calls, 1);
      expect(cubit.state.refundRequestedIds, isEmpty);
      response.completeError(const WorkspaceServicePending());
      await tick();
      expect(cubit.state.refundSubmittingIds, isEmpty);
      expect(cubit.state.errorMessage, S.current.workspaceServicePending);
      response = Completer<void>();
      cubit.requestRefund('a');
      response.complete();
      await tick();
      cubit.selectBranchTab(1);
      cubit.requestRefund('a');
      expect(calls, 2);
      expect(cubit.state.refundRequestedIds, contains('a'));
    },
  );

  test(
    'employee form normalizes Persian digits and validates required fields',
    () async {
      final cubit = EmployeeFormCubit(null);
      addTearDown(cubit.close);
      expect(cubit.isValid, isFalse);
      cubit.update('firstName', 'علی');
      cubit.update('lastName', 'موسوی');
      cubit.update('nationalId', '۰۰۸۱۲۳۴۵۶۲');
      cubit.update('mobile', '۰۹۱۲۱۲۳۴۳۲۵');
      cubit.update('position', 'حسابدار');
      expect(cubit.isValid, isTrue);
      cubit.update('nationalId', 'bad-data');
      expect(cubit.isValid, isFalse);
    },
  );

  test(
    'terms interceptor handles only explicitly matched 403 responses',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = Prefs(await SharedPreferences.getInstance());
      var notifications = 0;
      final dio = ServiceUtil.createDio(
        prefs,
        isTermsRequired: (error) =>
            (error.response?.data as Map?)?['terms_required'] == true,
        onTermsRequired: () => notifications++,
      );
      addTearDown(dio.close);
      final adapter = _Local403Adapter();
      dio.httpClientAdapter = adapter;
      await expectLater(dio.get<void>('example'), throwsA(isA<DioException>()));
      expect(notifications, 0);
      adapter.termsRequired = true;
      await expectLater(dio.get<void>('example'), throwsA(isA<DioException>()));
      expect(notifications, 1);
    },
  );
}

class _Local403Adapter implements HttpClientAdapter {
  bool termsRequired = false;
  @override
  void close({bool force = false}) {}
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode({'terms_required': termsRequired}),
    403,
    headers: {
      Headers.contentTypeHeader: ['application/json'],
    },
  );
}
