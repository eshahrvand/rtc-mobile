import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_bar_chart_card.dart';
import '../../../widget/rtc_line_chart_card.dart';
import '../../../widget/rtc_message_card.dart';
import '../../../widget/rtc_pie_chart_card.dart';
import '../../../widget/rtc_pre_invoice_card.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import 'dashboard_quick_access_grid.dart';
import 'dashboard_recent_orders_header.dart';
import 'dashboard_ui_helpers.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.status == DashboardRequestStatus.loading &&
            state.quickAccessItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomRefreshIndicator(
          onRefresh: () async {
            context.read<DashboardCubit>().init();
          },
          builder: (context, child, controller) {
            return AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (!controller.isIdle)
                      Positioned(
                        top: 35.0 * controller.value,
                        child: SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: CircularProgressIndicator(
                            value: controller.isDragging || controller.isArmed
                                ? controller.value.clamp(0.0, 1.0)
                                : null,
                            color: AppColors.brandPalette.shade600,
                            strokeWidth: 3.0,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(0, 80.0 * controller.value),
                      child: child,
                    ),
                  ],
                );
              },
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              right: 16.0,
              left: 16.0,
              bottom: 20.0,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                DashboardQuickAccessGrid(items: state.quickAccessItems),
                RtcMessageCard(
                  message: state.messageText,
                  iconPath: state.messageIconPath,
                ),
                RtcPreInvoiceCard(
                  onTap: () => context.push(AppRoutes.preInvoice),
                ),
                if (state.lineChartData.isNotEmpty)
                  RtcLineChartCard(
                    line1Data: state.lineChartData.first.line1Data,
                    line2Data: state.lineChartData.first.line2Data,
                  ),
                RtcPieChartCard(
                  title: state.pieChart1Title,
                  data: state.pieChart1Data,
                ),
                RtcPieChartCard(
                  title: state.pieChart2Title,
                  data: state.pieChart2Data,
                  emptyMessage: S.current.noSell,
                  emptyImage: "assets/images/no-sell.svg",
                ),
                RtcBarChartCard(
                  title: state.barChartTitle,
                  data: state.barChartData,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                  child: Container(
                    height: 1.0,
                    width: double.infinity,
                    color: AppColors.grayPalette.shade200,
                  ),
                ),
                const DashboardRecentOrdersHeader(),
                DashboardUiHelpers.resolveRecentOrdersList(
                  context: context,
                  state: state,
                  theme: theme,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
