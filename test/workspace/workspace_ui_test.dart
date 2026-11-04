import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/main_ui_preview.dart';
import 'package:rtc_mobile/ui/preview/workspace_preview_app.dart';
import 'package:rtc_mobile/ui/preview/workspace_preview_data.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/branches/branch_detail_screen.dart';
import 'package:rtc_mobile/ui/presenters/branches/employee_editor_sheet.dart';
import 'package:rtc_mobile/ui/presenters/branches/employee_form_field.dart';
import 'package:rtc_mobile/ui/presenters/branches/employee_detail_screen.dart';
import 'package:rtc_mobile/ui/presenters/orders/widget/order_refund_widgets.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_message_card.dart';
import 'package:rtc_mobile/ui/widget/rtc_search_appbar.dart';
import 'package:rtc_mobile/ui/widget/rtc_chip_item.dart';
import 'package:rtc_mobile/ui/widget/rtc_selection_field.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/widget/profile_avatar.dart';
import 'package:avat_media_picker/avat_media_picker.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_bottom_sheet.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_option_item.dart';
import 'package:rtc_mobile/ui/presenters/orders/bloc/orders_cubit.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/bloc/pre_invoice_cubit.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/widget/pre_invoice_branch_view.dart';
import 'package:rtc_mobile/ui/widget/rtc_appbar.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/widget/home_banner_carousel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final boundaryKey = GlobalKey();
  late WorkspacePreviewData data;
  setUpAll(() async {
    final fonts = FontLoader('IranYekan')
      ..addFont(rootBundle.load('assets/fonts/IRANYekanXFaNum-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/IRANYekanXFaNum-Medium.ttf'))
      ..addFont(rootBundle.load('assets/fonts/IRANYekanXFaNum-Bold.ttf'));
    await fonts.load();
  });
  setUp(() async {
    await sl.reset();
    SharedPreferences.setMockInitialValues({});
    data = await initializeUiPreview();
  });
  tearDown(() async => sl.reset());

  Future<void> mount(WidgetTester tester, {double width = 375}) async {
    tester.view.physicalSize = Size(width, 814);
    tester.view.devicePixelRatio = 1;
    tester.view.padding = FakeViewPadding(top: 24, bottom: 40);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundaryKey,
        child: WorkspacePreviewApp(data: data),
      ),
    );
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final context = tester.element(find.byType(WorkspacePreviewGallery));
      for (final image in [
        'workspace_preview_natural.png',
        'workspace_preview_legal.png',
        'workspace_preview_employee.png',
        'workspace_rectangle34625736.png',
        'workspace_rectangle34625738.png',
        'rtc_logo.png',
        'workspace_logo.png',
      ]) {
        await precacheImage(AssetImage('assets/images/$image'), context);
      }
    });
    await tester.pumpAndSettle();
  }

  Future<void> capture(WidgetTester tester, String name) async {
    expect(tester.takeException(), isNull, reason: name);
    if (!const bool.fromEnvironment('RTC_SCREENSHOTS')) return;
    await tester.runAsync(() async {
      final render =
          boundaryKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final image = await render.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('/private/tmp/rtc_workspace_ui/$name.png');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes!.buffer.asUint8List());
      image.dispose();
    });
  }

  GoRouter router(WidgetTester tester) =>
      GoRouter.of(tester.element(find.byType(WorkspacePreviewGallery)));

  testWidgets('natural, legal and employee profiles render without overflow', (
    tester,
  ) async {
    await mount(tester);
    final navigation = router(tester);
    for (final mode in ['natural', 'legal', 'employee']) {
      setPreviewRole(
        sl<WorkspaceCubit>(),
        data,
        mode == 'employee' ? AccountRole.employee : AccountRole.agent,
        legal: mode == 'legal',
      );
      navigation.push('/profile');
      await tester.pumpAndSettle();
      await capture(tester, 'profile_$mode');
      if (mode == 'employee') {
        expect(find.text(S.current.agencyInformation), findsNothing);
        expect(find.text(S.current.employeePosition), findsOneWidget);
      } else {
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -600),
        );
        await tester.pumpAndSettle();
        await capture(tester, 'profile_${mode}_bottom');
      }
      navigation.pop();
      await tester.pumpAndSettle();
    }
  });

  testWidgets(
    'tapping the profile photo opens the image-only Avat picker for both roles',
    (tester) async {
      await mount(tester);
      final navigation = router(tester);
      final texts = AvatMediaPickerTexts.fa();
      for (final role in AccountRole.values) {
        setPreviewRole(sl<WorkspaceCubit>(), data, role);
        navigation.push('/profile');
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byType(ProfileAvatar),
            matching: find.byType(ClipOval),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(texts.cameraLabel), findsOneWidget);
        expect(find.text(texts.galleryLabel), findsOneWidget);
        expect(find.text(texts.fileLabel), findsNothing);
        await capture(tester, 'avatar_picker_${role.name}');
        Navigator.of(tester.element(find.text(texts.galleryLabel))).pop();
        await tester.pumpAndSettle();
        navigation.pop();
        await tester.pumpAndSettle();
      }
    },
  );

  testWidgets('terms are gated by agreement and employees cannot accept', (
    tester,
  ) async {
    await mount(tester);
    final cubit = sl<WorkspaceCubit>();
    cubit.requireTerms(document: data.updateTerms);
    await tester.pumpAndSettle();
    expect(find.byType(WorkspacePreviewGallery), findsNothing);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(cubit.state.termsRequired, isTrue);
    await capture(tester, 'terms_agent');
    expect(data.accepted, isFalse);
    final confirm = find.widgetWithText(RtcButton, S.current.confirmNewTerms);
    expect(tester.widget<RtcButton>(confirm).isActive, isFalse);
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await capture(tester, 'terms_agent_checked');
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(cubit.state.termsRequired, isFalse);
    expect(data.accepted, isTrue);
    setPreviewRole(cubit, data, AccountRole.employee);
    data.accepted = false;
    cubit.requireTerms(document: data.updateTerms);
    await tester.pumpAndSettle();
    await capture(tester, 'terms_employee');
    expect(find.byType(Checkbox), findsNothing);
    await tester.tap(find.text(S.current.recheckTerms));
    await tester.pumpAndSettle();
    expect(cubit.state.termsRequired, isTrue);
    data.accepted = true;
    await tester.tap(find.text(S.current.recheckTerms));
    await tester.pumpAndSettle();
    expect(cubit.state.termsRequired, isFalse);
  });

  testWidgets(
    'policy PDF downloads before acceptance and shows success in the gate overlay',
    (tester) async {
      final saved = Completer<String>();
      var downloads = 0;
      await sl.unregister<WorkspaceCubit>();
      final cubit = WorkspaceCubit(
        WorkspaceRepository(
          loadPolicyHtml: (id) {
            expect(id, 'policy-3');
            downloads++;
            return Future.value('<html>قوانین</html>');
          },
        ),
        exportHtml: (_, _) => saved.future,
      );
      sl.registerSingleton<WorkspaceCubit>(
        cubit,
        dispose: (value) => value.close(),
      );
      await mount(tester);
      cubit.requireTerms(
        document: const TermsDocument(
          id: 'policy-3',
          version: '3',
          versionLabel: 'نسخه ۳',
          markdown: 'قوانین',
          publishedAt: '',
        ),
      );
      await tester.pumpAndSettle();
      expect(cubit.state.termsChecked, isFalse);
      expect(find.byType(WorkspacePreviewGallery), findsNothing);
      await tester.tap(find.widgetWithText(RtcButton, S.current.downloadTerms));
      await tester.pump();
      expect(cubit.state.policyDownloadLoading, isTrue);
      saved.complete('/Download/privacy_policy_policy-3.pdf');
      await tester.pumpAndSettle();
      expect(downloads, 1);
      expect(cubit.state.policyDownloadLoading, isFalse);
      expect(cubit.state.policyDownloadSaved, isTrue);
      expect(cubit.state.termsRequired, isTrue);
      expect(cubit.state.termsChecked, isFalse);
      expect(find.text(S.current.policyDownloadedSuccess), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pump(const Duration(seconds: 4));
      expect(find.text(S.current.policyDownloadedSuccess), findsNothing);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(cubit.state.termsRequired, isTrue);
    },
  );

  testWidgets('terms page, drawer and service-sized banners render', (
    tester,
  ) async {
    await mount(tester);
    final navigation = router(tester);
    navigation.push('/terms');
    await tester.pumpAndSettle();
    await capture(tester, 'terms_page');
    navigation.pop();
    await tester.pumpAndSettle();
    navigation.push('/dashboard');
    await tester.pumpAndSettle();
    expect(find.byType(RtcMessageCard), findsOneWidget);
    setPreviewRole(sl<WorkspaceCubit>(), data, AccountRole.employee);
    await tester.pumpAndSettle();
    expect(find.byType(RtcMessageCard), findsNothing);
    setPreviewRole(sl<WorkspaceCubit>(), data, AccountRole.agent);
    await tester.pumpAndSettle();
    expect(find.byType(RtcMessageCard), findsOneWidget);
    await tester.ensureVisible(find.byType(HomeBannerCarousel));
    await tester.pumpAndSettle();
    await capture(tester, 'home_banner');
    final page = find.descendant(
      of: find.byType(HomeBannerCarousel),
      matching: find.byType(PageView),
    );
    expect(tester.getSize(page).height, 113);
    await tester.drag(page, const Offset(-260, 0));
    await tester.pumpAndSettle();
    await capture(tester, 'home_banner_swiped');
    await tester.tap(find.byType(RtcAppBar).first);
    await tester.pumpAndSettle();
    // Open via scaffold to avoid relying on the icon hit area.
    tester.state<ScaffoldState>(find.byType(Scaffold).last).openDrawer();
    await tester.pumpAndSettle();
    await capture(tester, 'drawer_agent');
    await tester.tap(find.text(S.current.workspaceReports));
    await tester.pumpAndSettle();
    expect(find.text(S.current.commissionDrawerTitle), findsOneWidget);
    setPreviewRole(sl<WorkspaceCubit>(), data, AccountRole.employee);
    await tester.pumpAndSettle();
    expect(find.text(S.current.branchManagement), findsNothing);
    expect(find.text(S.current.commissionDrawerTitle), findsNothing);
    if (find.text(S.current.workspaceSales).evaluate().isEmpty) {
      await tester.tap(find.text(S.current.workspaceReports));
      await tester.pumpAndSettle();
    }
    expect(find.text(S.current.commissionDrawerTitle), findsNothing);
    expect(find.text(S.current.workspaceSales), findsOneWidget);
    await capture(tester, 'drawer_employee');
  });

  testWidgets('drawer orders opens and branch filter uses selection sheet', (
    tester,
  ) async {
    await mount(tester);
    router(tester).push('/dashboard');
    await tester.pumpAndSettle();
    tester.state<ScaffoldState>(find.byType(Scaffold).last).openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.myOrders));
    await tester.pumpAndSettle();
    expect(find.text(S.current.orderBranchFilter), findsOneWidget);
    expect(
      tester.widget<RtcChipItem>(find.byType(RtcChipItem).first).chip.id,
      4,
    );
    await tester.tap(find.text(S.current.orderBranchFilter));
    await tester.pumpAndSettle();
    expect(find.byType(FilterBottomSheet), findsOneWidget);
    await tester.tap(find.text('تهران - ارگ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.applyFilter));
    await tester.pumpAndSettle();
    final context = tester.element(find.text(S.current.orderBranchFilter));
    expect(context.read<OrdersCubit>().state.selectedStoreId, '1');
    await capture(tester, 'orders_branch_filter');
  });

  testWidgets('employee invalid national ID and mobile show field errors', (
    tester,
  ) async {
    await mount(tester);
    router(tester).push('/branches');
    await tester.pumpAndSettle();
    await tester.tap(find.text('تهران - ارگ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.branchUsers));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.addBranchUser));
    await tester.pumpAndSettle();
    for (final index in [2, 3]) {
      await tester.enterText(
        find.descendant(
          of: find.byType(EmployeeFormField).at(index),
          matching: find.byType(TextFormField),
        ),
        '123',
      );
    }
    await tester.pumpAndSettle();
    expect(find.text(S.current.nationalIdWrong), findsOneWidget);
    expect(find.text(S.current.phoneNumberWrong), findsOneWidget);
    for (final message in [
      S.current.nationalIdWrong,
      S.current.phoneNumberWrong,
    ]) {
      expect(
        tester.getTopRight(find.text(message)).dx,
        closeTo(tester.getTopRight(find.byType(EmployeeFormField).at(2)).dx, 1),
      );
      expect(
        tester.widget<Text>(find.text(message)).textAlign,
        TextAlign.right,
      );
    }
    await capture(tester, 'employee_validation_errors');
    await tester.tap(find.byType(RtcSelectionField));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(FilterBottomSheet),
        matching: find.text(S.current.storeUserPosition),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(FilterBottomSheet),
        matching: find.text(S.current.shopAccountant),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(FilterBottomSheet),
        matching: find.text(S.current.shopSupervisor),
      ),
      findsOneWidget,
    );
    expect(find.text(S.current.clearFilter), findsNothing);
    expect(find.text(S.current.applyFilter), findsNothing);
    expect(find.text(S.current.confirm), findsOneWidget);
    expect(find.text(S.current.back), findsWidgets);
    await capture(tester, 'employee_position_sheet');
  });

  testWidgets(
    'branch search cancel is vertically aligned with the search field',
    (tester) async {
      await mount(tester);
      router(tester).push('/branches');
      await tester.pumpAndSettle();
      tester
          .widget<RtcSearchAppBar>(find.byType(RtcSearchAppBar))
          .onSearchActivated();
      await tester.pumpAndSettle();
      final search = find.descendant(
        of: find.byType(RtcSearchAppBar),
        matching: find.byType(TextFormField),
      );
      await capture(tester, 'branch_search_cancel');
      expect(
        tester.getCenter(find.text('لغو')).dy,
        closeTo(tester.getCenter(search).dy, 1),
      );
      await capture(tester, 'branch_search_cancel');
      await tester.tap(find.text('لغو'));
      await tester.pumpAndSettle();
      expect(sl<WorkspaceCubit>().state.branchSearchActive, isFalse);
    },
  );

  testWidgets(
    'employee information photo is read-only for the representative',
    (tester) async {
      await mount(tester);
      router(tester).push('/branches');
      await tester.pumpAndSettle();
      await tester.tap(find.text('تهران - ارگ'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.branchUsers));
      await tester.pumpAndSettle();
      await tester.tap(find.text('علی موسوی'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(EmployeeDetailScreen),
          matching: find.byType(ClipOval),
        ),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();
      final texts = AvatMediaPickerTexts.fa();
      expect(find.text(texts.cameraLabel), findsNothing);
      expect(find.text(texts.galleryLabel), findsNothing);
      expect(find.text(texts.fileLabel), findsNothing);
      await capture(tester, 'employee_information_avatar_readonly');
    },
  );

  testWidgets('branch search, swipe tabs, empty users, add and edit sheets', (
    tester,
  ) async {
    await mount(tester);
    router(tester).push('/branches');
    await tester.pumpAndSettle();
    await capture(tester, 'branches');
    final cubit = sl<WorkspaceCubit>();
    cubit.toggleBranchSearch();
    cubit.searchBranches('مشهد');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('تهران - ارگ'), findsNothing);
    expect(find.text('مشهد - ارگ'), findsOneWidget);
    cubit.toggleBranchSearch();
    await tester.pumpAndSettle();
    await tester.tap(find.text('تهران - ارگ'));
    await tester.pumpAndSettle();
    await capture(tester, 'branch_information');
    await tester.drag(find.byType(PageView), const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(cubit.state.branchTab, 1);
    await capture(tester, 'branch_employees');
    await tester.tap(find.text(S.current.addBranchUser));
    await tester.pumpAndSettle();
    await capture(tester, 'employee_add');
    expect(
      tester
          .widget<RtcButton>(
            find.widgetWithText(RtcButton, S.current.saveBranchUser),
          )
          .isActive,
      isFalse,
    );
    await tester.tap(find.text(S.current.back));
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(BranchDetailScreen));
    EmployeeEditorSheet.show(context, employee: cubit.state.employees[1]);
    await tester.pumpAndSettle();
    await capture(tester, 'employee_edit');
    await tester.tap(find.byTooltip(S.current.deleteBranchUser));
    await tester.pumpAndSettle();
    await capture(tester, 'employee_delete');
    await tester.tap(find.text(S.current.cancelWorkspace));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.back));
    await tester.pumpAndSettle();
    cubit.selectBranch(WorkspacePreviewData.branches[2]);
    cubit.selectBranchTab(1);
    await tester.pumpAndSettle();
    await capture(tester, 'branch_employees_empty');
  });

  testWidgets(
    'invoice branch selection is required only for multi-branch agents',
    (tester) async {
      await mount(tester);
      final navigation = router(tester);
      navigation.push('/preview/invoice?branch=true');
      await tester.pumpAndSettle();
      expect(find.byType(PreInvoiceBranchView), findsOneWidget);
      expect(find.text('مرحله 1 از 6'), findsOneWidget);
      expect(
        tester.widget<RtcButton>(find.byType(RtcButton).last).isActive,
        isFalse,
      );
      final promptTop = tester
          .getTopLeft(find.text(S.current.selectInvoiceBranchPrompt))
          .dy;
      expect(promptTop, closeTo(168, 1));
      await capture(tester, 'invoice_branch_empty');
      await tester.tap(find.byType(RtcSelectionField));
      await tester.pumpAndSettle();
      expect(find.byType(FilterBottomSheet), findsOneWidget);
      expect(find.text(S.current.clearFilter), findsNothing);
      expect(find.text(S.current.applyFilter), findsNothing);
      expect(find.text(S.current.confirm), findsOneWidget);
      await capture(tester, 'invoice_branch_options');
      await tester.tap(find.text('تهران - ارگ').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.confirm));
      await tester.pumpAndSettle();
      expect(
        tester.widget<RtcButton>(find.byType(RtcButton).last).isActive,
        isTrue,
      );
      final cubit = tester
          .element(find.byType(PreInvoiceBranchView))
          .read<PreInvoiceCubit>();
      expect(cubit.branchSelection.state.selected?.id, '1');
      final selectedText = tester.widget<EditableText>(
        find.descendant(
          of: find.byType(RtcSelectionField),
          matching: find.byType(EditableText),
        ),
      );
      expect(selectedText.controller.text, 'تهران - ارگ');
      await capture(tester, 'invoice_branch_selected');
      await tester.tap(find.byType(RtcSelectionField));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<FilterBottomSheet>(find.byType(FilterBottomSheet))
            .initialSelectedId,
        '1',
      );
      expect(
        tester
            .widgetList<FilterOptionItem>(find.byType(FilterOptionItem))
            .singleWhere((item) => item.title == 'تهران - ارگ')
            .isSelected,
        isTrue,
      );
      await capture(tester, 'invoice_branch_reopened');
      await tester.tap(find.text('تهران - ارگ').last);
      await tester.pumpAndSettle();
      expect(
        tester
            .widgetList<FilterOptionItem>(find.byType(FilterOptionItem))
            .singleWhere((item) => item.title == 'تهران - ارگ')
            .isSelected,
        isTrue,
      );
      await tester.tap(find.text(S.current.confirm));
      await tester.pumpAndSettle();

      await tester.tap(find.text(S.current.nextStep));
      await tester.pumpAndSettle();
      expect(find.text('مرحله 2 از 6'), findsOneWidget);
      tester.widget<RtcAppBar>(find.byType(RtcAppBar).last).onBack!();
      await tester.pumpAndSettle();
      expect(find.byType(PreInvoiceBranchView), findsOneWidget);
      expect(find.text('تهران - ارگ'), findsOneWidget);
      navigation.pop();
      await tester.pumpAndSettle();
      navigation.push('/preview/invoice?branch=true&branches=1');
      await tester.pumpAndSettle();
      expect(find.byType(PreInvoiceBranchView), findsNothing);
      expect(find.text('مرحله 1 از 5'), findsOneWidget);
      await capture(tester, 'invoice_single_branch');
      navigation.pop();
      await tester.pumpAndSettle();
      setPreviewRole(sl<WorkspaceCubit>(), data, AccountRole.employee);
      navigation.push('/preview/invoice?branch=true');
      await tester.pumpAndSettle();
      expect(find.byType(PreInvoiceBranchView), findsNothing);
      expect(find.text('مرحله 1 از 5'), findsOneWidget);
      await capture(tester, 'invoice_employee_start');
    },
  );

  testWidgets('invoice branch and consumer summary fit a narrow screen', (
    tester,
  ) async {
    await mount(tester, width: 320);
    final navigation = router(tester);
    navigation.push('/preview/invoice?branch=true');
    await tester.pumpAndSettle();
    await capture(tester, 'invoice_branch_narrow');
    navigation.pop();
    await tester.pumpAndSettle();
    navigation.push('/preview/invoice?review=true&delivery=other');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(S.current.consumerFinalAmount));
    await tester.pumpAndSettle();
    expect(find.text('18,000,000'), findsOneWidget);
    await capture(tester, 'invoice_consumer_summary_narrow');
  });

  testWidgets('delivery recipient and three review variants render', (
    tester,
  ) async {
    await mount(tester);
    final navigation = router(tester);
    navigation.push('/preview/invoice?delivery=other');
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    await capture(tester, 'delivery_recipient');
    navigation.pop();
    await tester.pumpAndSettle();
    for (final delivery in ['store', 'customer', 'other']) {
      navigation.push('/preview/invoice?review=true&delivery=$delivery');
      await tester.pumpAndSettle();
      await capture(tester, 'review_$delivery');
      expect(
        find.text(
          delivery == 'store'
              ? S.current.storeDeliveryAddress
              : S.current.customerDeliveryAddress,
        ),
        findsOneWidget,
      );
      if (delivery == 'other') {
        expect(find.text(S.current.recipientFullName), findsOneWidget);
        expect(find.text('سامان پارسی'), findsOneWidget);
        await tester.ensureVisible(find.text(S.current.recipientNationalId));
      } else {
        expect(find.text(S.current.recipientFullName), findsNothing);
        await tester.ensureVisible(find.text(S.current.deliveryDestination));
      }
      await tester.pumpAndSettle();
      await capture(tester, 'review_${delivery}_delivery');
      await tester.ensureVisible(find.text(S.current.consumerFinalAmount));
      await tester.pumpAndSettle();
      expect(find.text('18,000,000'), findsOneWidget);
      await capture(tester, 'review_${delivery}_financial');
      navigation.pop();
      await tester.pumpAndSettle();
    }
  });

  testWidgets(
    'refund is hidden for agents and employees until the service is available',
    (tester) async {
      await mount(tester);
      router(tester).push('/preview/order');
      await tester.pumpAndSettle();
      for (final role in AccountRole.values) {
        setPreviewRole(sl<WorkspaceCubit>(), data, role);
        await tester.pumpAndSettle();
        expect(find.byTooltip(S.current.refundRequestTitle), findsNothing);
        expect(find.text(S.current.refundAwaitingReview), findsNothing);
        expect(find.byType(OrderRefundBadge), findsNothing);
        await capture(tester, 'refund_hidden_${role.name}');
      }
    },
  );
  testWidgets(
    'employee add, detail, edit and confirmed deletion update the same branch',
    (tester) async {
      await mount(tester);
      router(tester).push('/branches');
      await tester.pumpAndSettle();
      await tester.tap(find.text('تهران - ارگ'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.branchUsers));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.addBranchUser));
      await tester.pumpAndSettle();
      for (final entry in [
        'سپهر',
        'پارسا',
        '۰۰۸۱۲۳۴۵۶۲',
        '۰۹۱۲۱۲۳۴۳۲۵',
      ].asMap().entries) {
        final field = find.descendant(
          of: find.byType(EmployeeFormField).at(entry.key),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(field, entry.value);
      }
      await tester.tap(find.byType(RtcSelectionField));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.shopAccountant).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.confirm));
      await tester.pumpAndSettle();
      await capture(tester, 'employee_add_filled');
      await tester.tap(find.text(S.current.saveBranchUser));
      await tester.pumpAndSettle();
      expect(find.byType(EmployeeEditorSheet), findsNothing);
      expect(sl<WorkspaceCubit>().state.employees, hasLength(4));
      await tester.ensureVisible(find.text('سپهر پارسا'));
      await tester.tap(find.text('سپهر پارسا'));
      await tester.pumpAndSettle();
      await capture(tester, 'employee_detail_without_photo');
      await tester.tap(find.byTooltip(S.current.editBranchUserTitle));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(S.current.deleteBranchUser));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.confirmDeleteBranchUser));
      await tester.pumpAndSettle();
      expect(find.byType(EmployeeDetailScreen), findsNothing);
      expect(find.byType(BranchDetailScreen), findsOneWidget);
      expect(sl<WorkspaceCubit>().state.employees, hasLength(3));
      expect(find.text('سپهر پارسا'), findsNothing);
      await tester.tap(find.text('علی موسوی'));
      await tester.pumpAndSettle();
      await capture(tester, 'employee_detail_with_photo');
    },
  );

  testWidgets('small width and keyboard keep sheet actions reachable', (
    tester,
  ) async {
    await mount(tester, width: 320);
    final navigation = router(tester);
    sl<WorkspaceCubit>().requireTerms(document: data.updateTerms);
    await tester.pumpAndSettle();
    await capture(tester, 'terms_small_width');
    sl<WorkspaceCubit>().reset();
    setPreviewRole(sl<WorkspaceCubit>(), data, AccountRole.agent);
    navigation.push('/branches');
    await tester.pumpAndSettle();
    await tester.tap(find.text('تهران - ارگ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.branchUsers));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.addBranchUser));
    await tester.pumpAndSettle();
    tester.view.viewInsets = const FakeViewPadding(bottom: 290);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    await capture(tester, 'employee_keyboard');
    expect(
      tester
          .getRect(find.widgetWithText(RtcButton, S.current.saveBranchUser))
          .bottom,
      lessThan(814 - 290),
    );
  });
}
