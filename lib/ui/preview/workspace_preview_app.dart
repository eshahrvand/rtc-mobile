// This navigation gallery exists only in the separate UI-preview entry point.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/workspace_models.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../router/app_route.dart';
import '../theme/theme.dart';
import '../widget/rtc_appbar.dart';
import '../widget/rtc_drawer.dart';
import '../presenters/dashboard/widget/profile.dart';
import '../presenters/dashboard/bloc/dashboard_cubit.dart';
import '../presenters/dashboard/widget/dashboard_body.dart';
import '../presenters/terms/terms_screen.dart';
import '../presenters/terms/terms_gate.dart';
import '../presenters/branches/branches_screen.dart';
import '../presenters/branches/branch_detail_screen.dart';
import '../presenters/branches/employee_detail_screen.dart';
import '../presenters/pre_invoice/pre_invoice.dart';
import '../presenters/pre_invoice/bloc/pre_invoice_cubit.dart';
import '../presenters/orders/bloc/orders_cubit.dart';
import '../presenters/orders/orders_body.dart';
import '../presenters/orders/widget/order_detail_view.dart';
import '../presenters/workspace/bloc/workspace_cubit.dart';
import 'workspace_preview_data.dart';

class WorkspacePreviewApp extends StatefulWidget {
  const WorkspacePreviewApp({super.key, required this.data});
  final WorkspacePreviewData data;
  @override
  State<WorkspacePreviewApp> createState() => _WorkspacePreviewAppState();
}

class _WorkspacePreviewAppState extends State<WorkspacePreviewApp> {
  late final workspace = sl<WorkspaceCubit>();
  late final GoRouter router = GoRouter(
    initialLocation: '/preview',
    routes: [
      GoRoute(
        path: '/preview',
        builder: (_, state) => WorkspacePreviewGallery(data: widget.data),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (_, state) => WorkspacePreviewGallery(data: widget.data),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (_, state) {
          return const TermsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.branches,
        builder: (_, state) {
          return const BranchesScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.branchDetail,
        builder: (_, state) => const BranchDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.employeeDetail,
        builder: (_, state) =>
            EmployeeDetailScreen(employeeId: state.extra as String),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (_, state) => PreviewHome(data: widget.data),
      ),
      GoRoute(
        path: '/preview/invoice',
        builder: (_, state) => BlocProvider<PreInvoiceCubit>(
          create: (_) => PreviewPreInvoiceCubit(
            widget.data.invoice(
              review: state.uri.queryParameters['review'] == 'true',
              deliverToCustomer:
                  state.uri.queryParameters['delivery'] != 'store',
              otherRecipient: state.uri.queryParameters['delivery'] == 'other',
            ),
            startFromBeginning: state.uri.queryParameters['branch'] == 'true',
            branches: state.uri.queryParameters['branches'] == '1'
                ? WorkspacePreviewData.branches.take(1).toList()
                : WorkspacePreviewData.branches,
          ),
          child: const PreInvoiceView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (_, state) => BlocProvider<OrdersCubit>(
          create: (_) => PreviewOrdersCubit(widget.data.order),
          child: Scaffold(
            appBar: RtcAppBar(
              title: S.current.myOrders,
              onBack: () => router.go('/preview'),
            ),
            body: const OrdersBody(),
          ),
        ),
      ),
      GoRoute(
        path: '/preview/order',
        builder: (_, state) => BlocProvider<OrdersCubit>(
          create: (_) => PreviewOrdersCubit(widget.data.order),
          child: const OrderDetailView(orderId: 'preview-order'),
        ),
      ),
    ],
  );
  @override
  void initState() {
    super.initState();
    setPreviewRole(workspace, widget.data, AccountRole.agent);
    workspace.loadTerms();
    workspace.loadHomeBanners();
  }

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: workspace,
    child: MaterialApp.router(
      routerConfig: router,
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: (context, child) => TermsGate(
        child: child!,
        onLogout: () {
          workspace.reset();
          router.go('/preview');
        },
      ),
    ),
  );
}

void setPreviewRole(
  WorkspaceCubit workspace,
  WorkspacePreviewData data,
  AccountRole role, {
  bool legal = false,
}) {
  workspace.setProfile(
    data.profile(employee: role == AccountRole.employee, legal: legal),
    role: role,
    position: S.current.shopSupervisor,
    postalCode: '1939494311',
    companyName: 'آوات',
    avatar:
        'assets/images/workspace_preview_${role == AccountRole.employee
            ? 'employee'
            : legal
            ? 'legal'
            : 'natural'}.png',
  );
}

class WorkspacePreviewGallery extends StatelessWidget {
  const WorkspacePreviewGallery({super.key, required this.data});
  final WorkspacePreviewData data;
  @override
  Widget build(BuildContext context) {
    final workspace = context.read<WorkspaceCubit>();
    return Scaffold(
      appBar: const RtcAppBar(title: 'UI Preview', hideBackIcon: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: Text(S.current.naturalAgent),
                onPressed: () =>
                    setPreviewRole(workspace, data, AccountRole.agent),
              ),
              ActionChip(
                label: Text(S.current.legalAgent),
                onPressed: () => setPreviewRole(
                  workspace,
                  data,
                  AccountRole.agent,
                  legal: true,
                ),
              ),
              ActionChip(
                label: Text(S.current.branchUsers),
                onPressed: () =>
                    setPreviewRole(workspace, data, AccountRole.employee),
              ),
            ],
          ),
          ListTile(
            title: Text(S.current.profile),
            onTap: () => context.push(AppRoutes.profile),
          ),
          ListTile(
            title: Text(S.current.termsTitle),
            onTap: () => context.push(AppRoutes.terms),
          ),
          ListTile(
            title: Text(S.current.termsUpdateTitle),
            onTap: () => workspace.requireTerms(document: data.updateTerms),
          ),
          ListTile(
            title: Text(S.current.branchManagement),
            onTap: () => context.push(AppRoutes.branches),
          ),
          ListTile(
            title: Text(S.current.dashboard),
            onTap: () => context.push(AppRoutes.dashboard),
          ),
          ListTile(
            title: Text(S.current.selectInvoiceBranch),
            onTap: () => context.push('/preview/invoice?branch=true'),
          ),
          ListTile(
            title: Text(S.current.customerInfo),
            onTap: () => context.push('/preview/invoice?delivery=other'),
          ),
          for (final delivery in ['store', 'customer', 'other'])
            ListTile(
              title: Text(
                '${S.current.reviewAndSubmit} · ${delivery == 'store'
                    ? S.current.storeDeliveryAddress
                    : delivery == 'other'
                    ? S.current.recipientFullName
                    : S.current.customerDeliveryAddress}',
              ),
              onTap: () => context.push(
                '/preview/invoice?review=true&delivery=$delivery',
              ),
            ),
          ListTile(
            title: Text(S.current.refundRequestTitle),
            onTap: () => context.push('/preview/order'),
          ),
        ],
      ),
    );
  }
}

class PreviewHome extends StatefulWidget {
  const PreviewHome({super.key, required this.data});
  final WorkspacePreviewData data;
  @override
  State<PreviewHome> createState() => _PreviewHomeState();
}

class _PreviewHomeState extends State<PreviewHome> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) => BlocProvider<DashboardCubit>(
    create: (_) => PreviewDashboardCubit(widget.data.dashboard),
    child: Scaffold(
      key: _key,
      appBar: RtcAppBar(
        onBack: () => _key.currentState?.openDrawer(),
        backIconPath: 'assets/images/drawer_menu.svg',
        title: '',
      ),
      drawer: RtcDrawer(scaffoldKey: _key),
      body: const DashboardBody(),
    ),
  );
}
