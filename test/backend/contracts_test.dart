import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rtc_mobile/config/errorhandler.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/data_source/local/prefs/prefs.dart';
import 'package:rtc_mobile/data_source/remote/service_util.dart';
import 'package:rtc_mobile/data_source/remote/workspace/workspace_service.dart';
import 'package:rtc_mobile/data_source/remote/profile/model/user_profile_dto_model.dart';
import 'package:rtc_mobile/data_source/remote/orders/model/order_dto_model.dart';
import 'package:rtc_mobile/data_source/remote/orders/orders_service.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/repository/orders/orders_repository.dart';
import 'package:rtc_mobile/repository/workspace/workspace_mapper.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_state.dart';

Map<String, dynamic> meJson({String role = 'agent', bool? required}) => {
  'id': 'user-1',
  'mobile': '09121234325',
  'role': role,
  'first_name': 'علی',
  'last_name': 'راد',
  'is_active': true,
  'date_joined': '2026-11-01T12:00:00Z',
  'postal_code': '1234567890',
  'stores_count': 2,
  'wallet_enabled': false,
  'documents': [
    {
      'id': 'doc',
      'file': {'id': 'file', 'file': '/file.pdf'},
      'created_at': '2026-11-01T12:00:00Z',
    },
  ],
  if (required != null)
    'policy_status': {
      'version': 3,
      'accepted_version': 2,
      'accepted_at': null,
      'required': required,
    },
};
Map<String, dynamic> policyJson([int version = 3]) => {
  'id': 'policy-$version',
  'version': version,
  'clauses': [
    {'title': 'بند اول', 'body': '**متن قوانین**'},
    {'title': 'بند دوم', 'body': 'توضیحات'},
  ],
  'published_at': '2026-11-01T10:00:00+03:30',
  'accepted_at': null,
};
Map<String, dynamic> storeJson(String id) => {
  'id': id,
  'name': 'شعبه $id',
  'province': {'id': 'p', 'name': 'تهران'},
  'city': {'id': 'c', 'name': 'تهران'},
  'postal_code': '1234567890',
  'address': 'نشانی',
  'is_active': true,
};
Map<String, dynamic> employeeJson() => {
  'id': 'employee-1',
  'mobile': '09121234325',
  'first_name': 'علی',
  'last_name': 'راد',
  'national_code': '0081234562',
  'position': 'store_accountant',
  'is_active': true,
  'store': {'id': 'store-1', 'name': 'تهران'},
  'avatar': {'file': '/avatar.png'},
};
Map<String, dynamic> orderJson() => {
  'id': 'order-1',
  'customer': {
    'id': 'customer-1',
    'first_name': 'علی',
    'last_name': 'راد',
    'national_id': '0081234562',
    'mobile': '09121234325',
    'address': 'نشانی',
    'postal_code': '1234567890',
  },
  'sub_plan': {'id': 'plan-1', 'name': 'طرح', 'repayment_duration_months': 12},
  'status': 'pre_invoice',
  'total': 2000,
  'created_at': '2026-11-01T12:00:00Z',
  'store': {'id': 'store-1', 'name': 'تهران'},
  'created_by': {
    'id': 'employee-1',
    'first_name': 'علی',
    'last_name': 'راد',
    'role': 'sales_person',
  },
  'receiver_full_name': 'سامان پارسی',
  'receiver_national_id': '0081234562',
  'delivery_to_agent': false,
  'base_total': 2500,
  'settlement_amount': 1800,
  'wallet_enabled': false,
};

class LocalAdapter implements HttpClientAdapter {
  LocalAdapter(this.respond);
  final (int, Object?) Function(RequestOptions) respond;
  final requests = <RequestOptions>[];
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final (status, data) = respond(options);
    return ResponseBody.fromString(
      data is String ? data : jsonEncode(data),
      status,
      headers: {
        Headers.contentTypeHeader: [
          data is String ? 'text/html' : 'application/json',
        ],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 5));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => S.load(const Locale('fa')));

  test(
    'me retains new nullable contract fields and round trips policy status',
    () {
      final me = UserProfileDtoModel.fromJson(meJson(required: true));
      expect(me.policyStatus!.required, isTrue);
      expect(me.policyStatus!.acceptedVersion, 2);
      expect(me.postalCode, '1234567890');
      expect(me.storesCount, 2);
      expect(me.walletEnabled, isFalse);
      expect(me.documents!.single.file['id'], 'file');
      final json = jsonDecode(jsonEncode(me.toJson())) as Map<String, dynamic>;
      expect(UserProfileDtoModel.fromJson(json).policyStatus!.required, isTrue);
      expect(UserProfileDtoModel.fromJson(meJson()).policyStatus, isNull);
      expect(me.copyWith(storesCount: 1).storesCount, 1);
    },
  );

  test(
    'policy mapper preserves clause order, Markdown and actual dates; accepts Swagger string',
    () {
      final document = WorkspaceMapper.policy(policyJson());
      expect(document.id, 'policy-3');
      expect(document.acceptedAt, isNull);
      expect(
        document.markdown,
        '## بند اول\n\n**متن قوانین**\n\n## بند دوم\n\nتوضیحات',
      );
      expect(document.publishedAt, contains('1405'));
      expect(document.versionLabel, contains('3'));
      expect(
        WorkspaceMapper.policy({
          ...policyJson(),
          'clauses': '# قوانین',
        }).markdown,
        '# قوانین',
      );
      expect(
        () => WorkspaceMapper.policy({...policyJson(), 'clauses': null}),
        throwsFormatException,
      );
    },
  );

  test(
    'only required decides the gate, employees cannot accept, staff never gate',
    () async {
      var loads = 0, accepts = 0;
      var me = UserProfileDtoModel.fromJson(meJson(required: true));
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          loadMe: () => Future.value(me),
          loadTerms: () {
            loads++;
            return Future.value(WorkspaceMapper.policy(policyJson()));
          },
          acceptTerms: (_) {
            accepts++;
            return Future.value(WorkspaceMapper.policy(policyJson()));
          },
        ),
      );
      addTearDown(cubit.close);
      cubit.setProfile(me);
      await settle();
      expect(cubit.state.policyGate, PolicyGate.mustAccept);
      expect(loads, 1);
      cubit.blockPolicy('policy_acceptance_required');
      await settle();
      expect(loads, 1);
      me = UserProfileDtoModel.fromJson(meJson(required: false));
      await cubit.refreshMe();
      expect(cubit.state.policyGate, PolicyGate.ok);
      cubit.setProfile(
        UserProfileDtoModel.fromJson(
          meJson(role: 'sales_person', required: true),
        ),
      );
      expect(cubit.state.policyGate, PolicyGate.agentPending);
      cubit.checkAgreement(true);
      cubit.confirmTerms();
      await settle();
      expect(accepts, 0);
      expect(loads, 1);
      cubit.setProfile(
        UserProfileDtoModel.fromJson(
          meJson(role: 'super_admin', required: true),
        ),
      );
      cubit.blockPolicy('policy_acceptance_required');
      expect(cubit.state.policyGate, PolicyGate.ok);
      cubit.setProfile(UserProfileDtoModel.fromJson(meJson()));
      expect(cubit.state.policyGate, PolicyGate.ok);
    },
  );

  test(
    'successful accept waits for a fresh me; outdated acceptance reloads text and checkbox',
    () async {
      final recheck = Completer<UserProfileDtoModel>();
      final shown = <String>[];
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          loadMe: () => recheck.future,
          loadTerms: () => Future.value(WorkspaceMapper.policy(policyJson())),
          acceptTerms: (version) {
            shown.add(version);
            return Future.value(WorkspaceMapper.policy(policyJson()));
          },
        ),
      );
      addTearDown(cubit.close);
      cubit.setProfile(UserProfileDtoModel.fromJson(meJson(required: true)));
      await settle();
      cubit.checkAgreement(true);
      cubit.confirmTerms();
      await settle();
      expect(shown, ['3']);
      expect(cubit.state.termsRequired, isTrue);
      recheck.complete(UserProfileDtoModel.fromJson(meJson(required: false)));
      await settle();
      expect(cubit.state.termsRequired, isFalse);
      var version = 3;
      final outdated = WorkspaceCubit(
        WorkspaceRepository(
          loadMe: () => Future.value(
            UserProfileDtoModel.fromJson(meJson(required: true)),
          ),
          loadTerms: () =>
              Future.value(WorkspaceMapper.policy(policyJson(version))),
          acceptTerms: (_) {
            version = 4;
            return Future.error(
              ApiError(
                statusCode: 422,
                code: 'policy_version_outdated',
                params: {'version': 4},
              ),
            );
          },
        ),
      );
      addTearDown(outdated.close);
      outdated.setProfile(UserProfileDtoModel.fromJson(meJson(required: true)));
      await settle();
      outdated.checkAgreement(true);
      outdated.confirmTerms();
      await settle();
      expect(outdated.state.termsRequired, isTrue);
      expect(outdated.state.terms!.version, '4');
      expect(outdated.state.termsChecked, isFalse);
    },
  );

  test(
    'paginated stores, scoped employees, CRUD and policy calls match supplied contracts',
    () async {
      final adapter = LocalAdapter((request) {
        if (request.path == 'accounts/stores')
          return (
            200,
            {
              'count': 2,
              'next': request.queryParameters['page'] == 1
                  ? 'https://another-host.invalid/accounts/stores?page=2'
                  : null,
              'results': [
                storeJson(request.queryParameters['page'].toString()),
              ],
            },
          );
        if (request.path == 'accounts/stores/1') return (200, storeJson('1'));
        if (request.path == 'accounts/sales-persons' && request.method == 'GET')
          return (
            200,
            {
              'next': null,
              'results': [employeeJson()],
            },
          );
        if (request.path.startsWith('accounts/sales-persons'))
          return (
            request.method == 'DELETE' ? 204 : 200,
            request.method == 'DELETE' ? null : employeeJson(),
          );
        if (request.path.endsWith('/document'))
          return (200, '<html>Policy</html>');
        return (200, policyJson());
      });
      final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/api/v1/'))
        ..httpClientAdapter = adapter;
      addTearDown(dio.close);
      final service = WorkspaceService(dio),
          repo = WorkspaceRepository.remote(WorkspaceService(dio));
      expect(await repo.loadBranches!(), hasLength(2));
      expect(
        adapter.requests
            .take(2)
            .every((request) => request.uri.host == 'local.invalid'),
        isTrue,
      );
      await repo.searchBranches!('تهران');
      expect(adapter.requests.last.queryParameters['search'], 'تهران');
      expect((await repo.loadBranch!('1')).id, '1');
      final employee = (await repo.loadEmployees!('store-1')).single;
      expect(adapter.requests.last.queryParameters['store'], 'store-1');
      expect(employee.position, S.current.shopAccountant);
      await repo.saveEmployee!(
        BranchEmployee(
          id: '',
          branchId: 'store-1',
          firstName: 'علی',
          lastName: 'راد',
          nationalId: '0081234562',
          mobile: '09121234325',
          position: S.current.shopAccountant,
        ),
      );
      expect(adapter.requests.last.method, 'POST');
      expect(adapter.requests.last.data['position'], 'store_accountant');
      await repo.saveEmployee!(employee);
      expect(adapter.requests.last.method, 'PATCH');
      await repo.loadEmployee!(employee.id);
      expect(adapter.requests.last.method, 'GET');
      await repo.deleteEmployee!(employee.id);
      expect(adapter.requests.last.method, 'DELETE');
      await repo.acceptTerms!('3');
      expect(adapter.requests.last.data, {'version': 3});
      expect(await service.policyHtml('policy-3'), '<html>Policy</html>');
      expect(adapter.requests.last.responseType, ResponseType.plain);
      final empty = Dio(BaseOptions(baseUrl: 'https://local.invalid/'))
        ..httpClientAdapter = LocalAdapter((_) => (404, {}));
      addTearDown(empty.close);
      expect(await WorkspaceService(empty).currentPolicy(), isNull);
    },
  );

  test(
    'order creation and list filter retain store and receiver, separate from totals',
    () async {
      final adapter = LocalAdapter(
        (request) => (
          200,
          request.method == 'POST'
              ? orderJson()
              : {
                  'count': 1,
                  'next': null,
                  'results': [orderJson()],
                },
        ),
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/api/v1/'))
        ..httpClientAdapter = adapter;
      addTearDown(dio.close);
      final repo = OrdersRepository(OrdersService(dio));
      final order = await repo.createOrder(
        const OrderCreateRequest(
          storeId: 'store-1',
          customerId: 'customer-1',
          subPlanId: 'plan-1',
          lines: [OrderLineRequest(productId: 'p', quantity: 2)],
          documents: [],
          deliveryToAgent: false,
          receiverFullName: 'سامان پارسی',
          receiverNationalId: '0081234562',
        ),
      );
      expect(adapter.requests.last.data['store'], 'store-1');
      expect(adapter.requests.last.data['receiver_full_name'], 'سامان پارسی');
      expect(order.store!.id, 'store-1');
      expect(order.createdBy!.role, 'sales_person');
      expect(order.baseTotal, 2500);
      expect(order.settlementAmount, 1800);
      expect(order.receiverNationalId, '0081234562');
      await repo.getOrders(storeId: 'store-1', page: 2);
      expect(adapter.requests.last.queryParameters['store'], 'store-1');
      final normal = const OrderCreateRequest(
        customerId: 'c',
        subPlanId: 'p',
        lines: [],
        documents: [],
        deliveryToAgent: true,
      ).toJson();
      expect(normal.containsKey('receiver_full_name'), isFalse);
      expect(normal.containsKey('store'), isFalse);
    },
  );

  test(
    'interceptor handles only gate codes, hides their snackbar and ignores ordinary 403',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = Prefs(await SharedPreferences.getInstance());
      await prefs.saveTokens(access: 'token', refresh: 'refresh');
      final blocked = <String>[];
      var meUpdates = 0;
      final dio = ServiceUtil.createDio(
        prefs,
        isTermsRequired: (error) =>
            error.response?.data is Map &&
            const {
              'policy_acceptance_required',
              'agent_policy_pending',
            }.contains(error.response!.data['error']?['code']),
        onPolicyBlocked: blocked.add,
        onAccountMe: (_) => meUpdates++,
      );
      addTearDown(dio.close);
      dio.httpClientAdapter = LocalAdapter(
        (request) => request.path == 'accounts/me'
            ? (200, meJson())
            : (
                403,
                {
                  'error': {'code': request.path},
                },
              ),
      );
      for (final code in [
        'policy_acceptance_required',
        'agent_policy_pending',
        'permission_denied',
      ]) {
        try {
          await dio.get<void>(code);
          fail('Expected 403');
        } on DioException catch (error) {
          expect(
            error.requestOptions.extra['policyGated'] == true,
            code != 'permission_denied',
          );
          expect(
            ErrorHandler.getMessage(error).isEmpty,
            code != 'permission_denied',
          );
        }
      }
      expect(blocked, ['policy_acceptance_required', 'agent_policy_pending']);
      await dio.get('accounts/me');
      expect(meUpdates, 1);
    },
  );
}
