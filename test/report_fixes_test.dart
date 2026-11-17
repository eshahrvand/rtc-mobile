import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/core/models/product_chip_model.dart';
import 'package:rtc_mobile/core/models/report_item_model.dart';
import 'package:rtc_mobile/data_source/remote/catalog/model/category_dto_model.dart';
import 'package:rtc_mobile/data_source/remote/plans/model/plan_dto_model.dart';
import 'package:rtc_mobile/data_source/remote/report/model/report_dto_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/repository/plans/plans_repository.dart';
import 'package:rtc_mobile/repository/product/product_repository.dart';
import 'package:rtc_mobile/repository/report/report_repository.dart';
import 'package:rtc_mobile/ui/presenters/report/bloc/report_cubit.dart';
import 'package:rtc_mobile/ui/presenters/report/bloc/report_step.dart';
import 'package:rtc_mobile/ui/presenters/report/widget/report_summary_card.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_empty_state.dart';
import 'package:rtc_mobile/ui/widget/rtc_inner_shadow.dart';
import 'package:rtc_mobile/ui/widget/rtc_search_appbar.dart';

class FakeReportRepo extends Fake implements ReportRepository {
  @override
  Future<ReportDataBundle<SalesOverviewResponse>> getSalesOverview({
    String? dateFrom,
    String? dateTo,
    String? subPlanId,
    String? search,
    int? page,
    bool includeSummary = true,
  }) async {
    return ReportDataBundle<SalesOverviewResponse>(
      response: const SalesOverviewResponse(count: 0, results: []),
      summary: null,
    );
  }

  @override
  List<ReportItemModel> mapToDomain(dynamic response, ReportStep step) => [];

  @override
  List<ReportSummaryMetric> mapSummaryToDomain(
    ReportSummaryDtoModel? summary,
    ReportStep step,
  ) => [];
}

class FakePlansRepo extends Fake implements PlansRepository {
  @override
  Future<SubPlanListResponse> getSubPlans({int? page}) async {
    return const SubPlanListResponse(count: 0, results: []);
  }
}

class FakeProductRepo extends Fake implements ProductRepository {
  @override
  Future<CategoryListResponse> getCategories({int? page}) async {
    return const CategoryListResponse(count: 0, results: []);
  }
}

void main() {
  setUpAll(() async {
    await S.load(const Locale('fa'));
  });

  group('Issue 1: RtcInnerShadow & ReportSummaryCard', () {
    testWidgets('RtcInnerShadow paints inner shadow without crashing', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RtcInnerShadow(
              shadows: AppColors.summaryShadow,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Colors.white,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: Text('Shadow Test'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Shadow Test'), findsOneWidget);
      expect(find.byType(RtcInnerShadow), findsOneWidget);
    });

    testWidgets('ReportSummaryCard uses RtcInnerShadow and displays metric', (
      tester,
    ) async {
      const metric = ReportSummaryMetric(
        label: 'مبلغ کل فروش',
        value: '2000000',
        isCurrency: true,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReportSummaryCard(metric: metric),
          ),
        ),
      );

      expect(find.byType(RtcInnerShadow), findsOneWidget);
      expect(find.text('مبلغ کل فروش'), findsOneWidget);
      expect(find.text('2,000,000'), findsOneWidget);
    });
  });

  group('Issue 2: Filter Isolation in ReportCubit', () {
    late ReportCubit cubit;

    setUp(() {
      sl.registerSingleton<ReportRepository>(FakeReportRepo());
      sl.registerSingleton<PlansRepository>(FakePlansRepo());
      sl.registerSingleton<ProductRepository>(FakeProductRepo());
      cubit = ReportCubit();
    });

    tearDown(() async {
      await cubit.close();
      await sl.reset();
    });

    test(
      'deactivating date chip (id: 4) only clears dates and preserves active plan filter',
      () async {
        cubit.init(ReportStep.sales);

        // Select both plan and date
        cubit.onPlanSelected('plan-uuid-123');
        cubit.onDateFilterApplied(
          Jalali(1403, 1, 1),
          Jalali(1403, 1, 31),
          'this_month',
        );

        expect(cubit.state.selectedPlanId, 'plan-uuid-123');
        expect(cubit.state.startDate, isNotNull);
        expect(cubit.state.dateOptionId, 'this_month');

        // Close date chip (id: 4)
        cubit.onChipClose(
          ProductChipModel(
            id: 4,
            label: 'تاریخ ثبت',
            opensBottomSheet: true,
          ),
        );

        // Date should be cleared
        expect(cubit.state.startDate, isNull);
        expect(cubit.state.endDate, isNull);
        expect(cubit.state.dateOptionId, isNull);

        // PLAN FILTER MUST STILL BE ACTIVE!
        expect(cubit.state.selectedPlanId, 'plan-uuid-123');
      },
    );
  });

  group('Issue 3: RtcSearchAppBar Back Button', () {
    testWidgets(
      'RtcSearchAppBar displays back button when showDrawerIcon is false',
      (tester) async {
        bool backTapped = false;
        final scaffoldKey = GlobalKey<ScaffoldState>();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              appBar: RtcSearchAppBar(
                isSearchActive: false,
                title: 'گزارش فروش',
                onSearchChanged: (_) {},
                onSearchActivated: () {},
                onSearchDeactivated: () {},
                scaffoldKey: scaffoldKey,
                showDrawerIcon: false,
                onBack: () => backTapped = true,
              ),
            ),
          ),
        );

        final backButtonFinder = find.byType(GestureDetector);
        expect(backButtonFinder, findsWidgets);

        await tester.tap(find.byWidgetPredicate(
          (widget) =>
              widget is GestureDetector &&
              widget.child is Container &&
              (widget.child as Container).alignment == Alignment.center,
        ));

        expect(backTapped, isTrue);
      },
    );
  });

  group('Issue 4: RtcEmptyState', () {
    testWidgets('RtcEmptyState renders image and message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RtcEmptyState(
              message: 'گزارشی یافت نشد',
            ),
          ),
        ),
      );

      expect(find.byType(RtcEmptyState), findsOneWidget);
      expect(find.text('گزارشی یافت نشد'), findsOneWidget);
    });
  });
}
