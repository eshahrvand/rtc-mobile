import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rtc_mobile/data_source/remote/auth/auth_service.dart';
import 'package:rtc_mobile/data_source/remote/dashboard/dashboard_service.dart';
import 'package:rtc_mobile/data_source/remote/orders/orders_service.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/repository/dashboard/dashboard_repository.dart';
import 'package:rtc_mobile/repository/orders/orders_repository.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/bloc/dashboard_cubit.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/bloc/dashboard_state.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'contracts_test.dart' show LocalAdapter, meJson;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => S.load(const Locale('fa')));
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'RTC',
      packageName: 'rtc',
      version: '1',
      buildNumber: '1',
      buildSignature: '',
    );
  });
  tearDown(() => sl.reset());

  for (final role in ['sales_person', 'agent']) {
    test('$role dashboard only requests permitted commission data', () async {
      final adapter = LocalAdapter((request) {
        switch (request.path) {
          case 'accounts/me':
            return (200, meJson(role: role, required: false));
          case 'dashboard/summary':
            return (
              200,
              {
                'wallet_balance': '-14220000.00',
                'order_count': 1,
                'order_count_delta': 1,
                'total_sales_amount': 120000000,
                'total_sales_delta_pct': 100.0,
                'active_orders': 77,
              },
            );
          case 'orders/orders':
            return (200, {'count': 0, 'results': [], 'next': null});
          case 'dashboard/commission':
            if (role == 'sales_person') {
              return (
                403,
                {
                  'error': {'code': 'permission_denied'},
                },
              );
            }
            return (
              200,
              {
                'monthly_sales_total': 120000000,
                'commission_rate_cash': 3,
                'commission_rate_product': 5,
                'commission_amount_cash': 3600000,
                'commission_amount_product': 6000000,
                'next_tier_rate_cash': 7,
                'next_tier_rate_product': 10,
                'distance_to_next_tier': 2880000000,
              },
            );
          default:
            if (request.path.startsWith('dashboard/')) return (200, []);
            throw StateError('Unexpected request: ${request.path}');
        }
      });
      final dio = Dio(BaseOptions(baseUrl: 'https://local.invalid/'))
        ..httpClientAdapter = adapter;
      addTearDown(dio.close);
      final workspace = WorkspaceCubit(WorkspaceRepository());
      sl.registerSingleton<WorkspaceCubit>(workspace);
      sl.registerSingleton<DashboardRepository>(
        DashboardRepository(DashboardService(dio), AuthService(dio)),
      );
      sl.registerSingleton<OrdersRepository>(
        OrdersRepository(OrdersService(dio)),
      );
      final cubit = DashboardCubit();
      addTearDown(cubit.close);
      addTearDown(workspace.close);
      final loaded = cubit.stream.firstWhere(
        (state) =>
            state.status == DashboardRequestStatus.success ||
            state.status == DashboardRequestStatus.error,
      );
      cubit.init();
      await loaded;
      expect(cubit.state.status, DashboardRequestStatus.success);
      expect(cubit.state.quickAccessItems, isNotEmpty);
      expect(
        adapter.requests.where((r) => r.path == 'dashboard/commission'),
        hasLength(role == 'agent' ? 1 : 0),
      );
      if (role == 'sales_person') {
        expect(cubit.state.commission, isNull);
        expect(cubit.state.messageText, isEmpty);
      } else {
        expect(cubit.state.commission?.commissionAmountCash, 3600000);
        expect(cubit.state.messageText, isNotEmpty);
      }
    });
  }
}
