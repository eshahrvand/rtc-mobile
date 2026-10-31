import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/repository/report/commission_report_repository.dart';
import 'package:rtc_mobile/ui/presenters/commission_report/bloc/commission_report_cubit.dart';
import 'package:rtc_mobile/ui/presenters/commission_report/bloc/commission_report_state.dart';
import 'support/commission_test_api.dart';

Future<void> waitForReport(CommissionReportCubit cubit) async {
  if (cubit.state.status == CommissionReportStatus.loading) {
    await cubit.stream.firstWhere(
      (state) => state.status != CommissionReportStatus.loading,
    );
  }
}

void main() {
  late CommissionTestApi api;
  late CommissionReportCubit cubit;
  setUpAll(() => S.load(const Locale('fa')));
  setUp(() {
    api = CommissionTestApi();
    sl.registerSingleton<CommissionReportRepository>(api.repository());
    cubit = CommissionReportCubit();
  });
  tearDown(() async {
    await cubit.close();
    await sl.reset();
  });

  test(
    'starts without period filters; maps totals from summary, not current page',
    () async {
      cubit.init();
      await waitForReport(cubit);
      expect(cubit.state.selectedYear, isNull);
      expect(cubit.state.selectedMonth, isNull);
      expect(api.requests.length, 2);
      expect(
        api.requests.map((request) => request.path),
        containsAll(['reports/commission', 'reports/commission/summary']),
      );
      for (final request in api.requests) {
        expect(request.queryParameters.containsKey('year'), isFalse);
        expect(request.queryParameters.containsKey('month'), isFalse);
        expect(request.queryParameters.containsKey('search'), isFalse);
      }
      expect(cubit.state.totalCount, 123);
      expect(cubit.state.entries.length, 1);
      expect(cubit.state.entries.first.customerName, 'پیمان خورسندی');
      expect(cubit.state.entries.first.planName, 'آپ - 12 ماهه');
      expect(
        cubit.state.entries.first.disbursedAt!.toUtc(),
        DateTime.parse('2026-10-30T09:37:43.520Z'),
      );
      expect(cubit.state.summaryMetrics.map((metric) => metric.value), [
        '2,000,000,000',
        '105,000,000',
        '5.25٪',
      ]);
    },
  );

  test(
    'debounces search and sends identical criteria to list and summary',
    () async {
      cubit.init();
      await waitForReport(cubit);
      cubit.selectYear(1404);
      await waitForReport(cubit);
      cubit.selectMonth(3);
      await waitForReport(cubit);
      api.requests.clear();
      cubit.onSearchChanged('پی');
      cubit.onSearchChanged('  پیمان  ');
      await waitForReport(cubit);
      expect(api.requests.length, 2);
      for (final request in api.requests) {
        expect(request.queryParameters['search'], 'پیمان');
        expect(request.queryParameters['year'], 1404);
        expect(request.queryParameters['month'], 3);
        expect(request.queryParameters.containsKey('store'), isFalse);
      }
      cubit.deactivateSearch();
      await waitForReport(cubit);
      expect(cubit.state.searchQuery, isEmpty);
      expect(cubit.state.selectedYear, 1404);
      expect(cubit.state.selectedMonth, 3);
      cubit.selectMonth(null);
      await waitForReport(cubit);
      expect(cubit.state.selectedMonth, isNull);
      expect(cubit.state.selectedYear, 1404);
      for (final request in api.requests.skip(api.requests.length - 2)) {
        expect(request.queryParameters.containsKey('month'), isFalse);
        expect(request.queryParameters['year'], 1404);
      }
    },
  );

  test(
    'pagination appends once, retains summary and uses server count',
    () async {
      cubit.init();
      await waitForReport(cubit);
      api.requests.clear();
      cubit.fetchNextPage();
      cubit.fetchNextPage();
      await pumpEventQueue();
      expect(api.requests.length, 1);
      expect(api.requests.single.queryParameters['page'], 2);
      expect(api.requests.single.queryParameters['page_size'], 20);
      expect(cubit.state.entries.length, 2);
      expect(cubit.state.hasMoreData, isFalse);
      expect(cubit.state.totalCount, 123);
      expect(cubit.state.summaryMetrics[0].value, '2,000,000,000');
      cubit.fetchNextPage();
      await pumpEventQueue();
      expect(api.requests.length, 1);
    },
  );

  test('ignores stale filter responses and responses after close', () async {
    cubit.init();
    await waitForReport(cubit);
    final oldList = Completer<ResponseBody>();
    final oldSummary = Completer<ResponseBody>();
    api.onRequest = (request) {
      if (request.queryParameters['year'] == 1404) {
        return request.path.endsWith('/summary')
            ? oldSummary.future
            : oldList.future;
      }
      return CommissionTestApi.response(
        request.path.endsWith('/summary')
            ? CommissionTestApi.summary(year: 1403)
            : CommissionTestApi.page(entryIndex: 3),
      );
    };
    cubit.selectYear(1404);
    await pumpEventQueue();
    cubit.selectYear(1403);
    await waitForReport(cubit);
    oldList.complete(
      CommissionTestApi.response(CommissionTestApi.page(entryIndex: 9)),
    );
    oldSummary.complete(
      CommissionTestApi.response(CommissionTestApi.summary(year: 1404)),
    );
    await pumpEventQueue();
    expect(cubit.state.selectedYear, 1403);
    expect(cubit.state.entries.single.orderNumber, '00000003');
    final pending = Completer<ResponseBody>();
    api.onRequest = (_) => pending.future;
    cubit.reload();
    await pumpEventQueue();
    await cubit.close();
    pending.complete(CommissionTestApi.response(CommissionTestApi.page()));
    await pumpEventQueue();
    expect(cubit.isClosed, isTrue);
  });

  test(
    'page errors preserve rows and allow retry without advancing page',
    () async {
      cubit.init();
      await waitForReport(cubit);
      api.onRequest = (_) => CommissionTestApi.response({
        'error': {'code': 'server_error', 'detail': 'Private server detail'},
      }, status: 500);
      cubit.fetchNextPage();
      await pumpEventQueue();
      expect(cubit.state.entries.length, 1);
      expect(cubit.state.currentPage, 1);
      expect(cubit.state.isPaginationLoading, isFalse);
      expect(cubit.state.paginationErrorMessage, isNot(contains('Private')));
      expect(cubit.state.paginationErrorMessage, isNotEmpty);
      api.onRequest = null;
      cubit.fetchNextPage();
      await pumpEventQueue();
      expect(cubit.state.entries.length, 2);
      expect(cubit.state.paginationErrorMessage, isEmpty);
    },
  );

  test('initial errors expose localized retry state, then recover', () async {
    api.onRequest = (_) => CommissionTestApi.response({
      'error': {'code': 'permission_denied', 'detail': 'Private server detail'},
    }, status: 403);
    cubit.init();
    await waitForReport(cubit);
    expect(cubit.state.status, CommissionReportStatus.error);
    expect(cubit.state.errorMessage, 'دسترسی مجاز نیست');
    expect(cubit.state.entries, isEmpty);
    api.onRequest = null;
    cubit.reload();
    await waitForReport(cubit);
    expect(cubit.state.status, CommissionReportStatus.success);
  });
}
