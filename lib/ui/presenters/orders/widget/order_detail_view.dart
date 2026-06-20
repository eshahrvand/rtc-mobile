import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/order_calculations.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_clearance_receipt_sheet.dart';
import 'order_upload_documents_sheet.dart';
import 'order_tab_details.dart';
import 'order_tab_financial.dart';
import 'order_tab_history.dart';
import 'orders_ui_helpers.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        context.go('${AppRoutes.dashboard}?index=2&refresh=$timestamp');
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<OrdersCubit, OrdersState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == OrdersRequestStatus.error) {
                rtcSnackBar(
                  context: context,
                  type: SnackBarType.error,
                  message: state.errorMessage,
                );
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listenWhen: (prev, curr) =>
                prev.uploadedClearanceDocPath != curr.uploadedClearanceDocPath,
            listener: (context, state) {
              if (state.uploadedClearanceDocPath != null &&
                  state.clearanceStep == ClearanceStep.documentsPending) {
                _showUploadConfirmation(
                  context,
                  context.read<OrdersCubit>(),
                  state.uploadedClearanceDocPath!,
                );
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listenWhen: (prev, curr) =>
                prev.clearanceStep != curr.clearanceStep,
            listener: (context, state) {
              if (state.clearanceStep == ClearanceStep.success) {
                _showSuccessReceipt(context, state);
              }
            },
          ),
          // Listener to sync PageView when state.selectedTabIndex changes
          BlocListener<OrdersCubit, OrdersState>(
            listenWhen: (prev, curr) =>
                prev.selectedTabIndex != curr.selectedTabIndex,
            listener: (context, state) {
              void syncPage() {
                if (_pageController.hasClients &&
                    _pageController.page?.toInt() != state.selectedTabIndex) {
                  // If it's the first transition to a non-zero tab, jump instantly
                  if (state.selectedTabIndex != 0 &&
                      (_pageController.positions.isEmpty ||
                          _pageController.page?.toInt() == 0)) {
                    _pageController.jumpToPage(state.selectedTabIndex);
                  } else {
                    _pageController.animateToPage(
                      state.selectedTabIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              }

              if (_pageController.hasClients) {
                syncPage();
              } else {
                // If the builder is still showing the loader, wait for the next frame
                // when PageView is actually in the widget tree.
                WidgetsBinding.instance.addPostFrameCallback((_) => syncPage());
              }
            },
          ),
        ],
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state.selectedOrder == null) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final order = state.selectedOrder!;
            final cubit = context.read<OrdersCubit>();

            return Scaffold(
              appBar: RtcAppBar(
                onBack: () {
                  final timestamp = DateTime.now().millisecondsSinceEpoch;
                  context.go(
                    '${AppRoutes.dashboard}?index=2&refresh=$timestamp',
                  );
                },
                backIconPath: '$baseImage/angle-right.svg',
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: RtcImage(
                      image: '$baseImage/print.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                ],
              ),

              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          OrdersUiHelpers.resolveValidityHeader(context, order),

                          RtcTabBar(
                            tabs: const [
                              'جزییات سفارش',
                              'اطلاعات مالی',
                              'تاریخچه',
                            ],
                            selectedIndex: state.selectedTabIndex,
                            onTabChanged: (index) => cubit.onTabChanged(index),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) => cubit.onTabChanged(index),
                        children: [
                          OrderTabDetails(order: order),
                          OrderTabFinancial(order: order),
                          OrderTabHistory(order: order),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showUploadConfirmation(
    BuildContext context,
    OrdersCubit cubit,
    String filePath,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return OrderUploadDocumentsSheet(
              filePath: filePath,
              isLoading: state.status == OrdersRequestStatus.loading,
              onConfirm: () {
                cubit.confirmClearanceDocument().then((_) {
                  if (context.mounted) Navigator.pop(context);
                }).catchError((_) {});
              },
              onDelete: () {
                cubit.clearClearanceDocument();
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }

  void _showSuccessReceipt(BuildContext context, OrdersState state) {
    OrderClearanceReceiptSheet.show(
      context,
      title: S.current.documentsSentSuccessTitle,
      subtitle: S.current.clearancePendingSubtitle,
      fields: [
        ReceiptField(
          label: S.current.proInvoiceNumberLabel,
          value: state.selectedOrder!.id.substring(0, 8).toUpperCase(),
        ),
        ReceiptField(
          label: S.current.customerLabelWithColon,
          value: state.selectedOrder!.customer.name,
        ),
        ReceiptField(
          label: S.current.clearanceAmountLabelWithColon,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.clearanceAmount,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              RtcImage(image: "$baseImage/rial.svg", boxFit: BoxFit.contain,width: 24, height: 24),
            ],
          ),
        ),
        ReceiptField(
          label: S.current.orderAmountLabel,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.selectedOrder!.financialSummary.finalAmount,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              RtcImage(image: "$baseImage/rial.svg",boxFit: BoxFit.contain, width: 24, height: 24),
            ],
          ),
        ),
        ReceiptField(
          label: S.current.gatewayLabel,
          value: state.selectedOrder?.creditPlan?.planName ?? 'تخلیه آفلاین',
        ),
        ReceiptField(
          label: S.current.documentSubmissionDateLabel,
          value: OrderCalculations.formatCurrentJalaliDateTime(),
        ),
      ],
      onGotIt: () {
        context.read<OrdersCubit>().resetClearance();
      },
    );
  }
}
