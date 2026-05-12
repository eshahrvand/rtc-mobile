import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_bar_chart_card.dart';
import '../../widget/rtc_bottom_nav.dart';
import '../../widget/rtc_line_chart_card.dart';
import '../../widget/rtc_message_card.dart';
import '../../widget/rtc_order_item.dart';
import '../../widget/rtc_pie_chart_card.dart';
import '../../widget/rtc_pre_invoice_card.dart';
import '../../widget/rtc_quick_access_item.dart';
import 'bloc/dashboard_cubit.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit()..init(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == DashboardRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor:
                      Colors.red, // // TODO: replace with theme values
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: RtcAppBar(
          onBack: () {},
          backIconPath: "$baseImage/drawer_menu.svg",
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardRequestStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // 4x Quick Access Containers
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (state.quickAccessItems.isNotEmpty)
                              RtcQuickAccessItem(
                                title: state.quickAccessItems[0].title,
                                value: state.quickAccessItems[0].value,
                                currency: state.quickAccessItems[0].currency,
                                iconPath: state.quickAccessItems[0].iconPath,
                                percentage:
                                    state.quickAccessItems[0].percentage,
                                onTap: () {},
                              ),
                            if (state.quickAccessItems.length > 1)
                              RtcQuickAccessItem(
                                title: state.quickAccessItems[1].title,
                                value: state.quickAccessItems[1].value,
                                currency: state.quickAccessItems[1].currency,
                                iconPath: state.quickAccessItems[1].iconPath,
                                percentage:
                                    state.quickAccessItems[1].percentage,
                                onTap: () {},
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            if (state.quickAccessItems.length > 2)
                              RtcQuickAccessItem(
                                title: state.quickAccessItems[2].title,
                                value: state.quickAccessItems[2].value,
                                currency: state.quickAccessItems[2].currency,
                                iconPath: state.quickAccessItems[2].iconPath,
                                percentage:
                                    state.quickAccessItems[2].percentage,
                                onTap: () {},
                              ),
                            if (state.quickAccessItems.length > 3)
                              RtcQuickAccessItem(
                                title: state.quickAccessItems[3].title,
                                value: state.quickAccessItems[3].value,
                                currency: state.quickAccessItems[3].currency,
                                iconPath: state.quickAccessItems[3].iconPath,
                                percentage:
                                    state.quickAccessItems[3].percentage,
                                onTap: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Message Container
                  if (state.messageText.isNotEmpty)
                    RtcMessageCard(
                      message: state.messageText,
                      iconPath: state.messageIconPath,
                    ),

                  // Pre-Invoice Container
                  RtcPreInvoiceCard(onTap: () {}),

                  // Line Chart
                  if (state.lineChartData.isNotEmpty)
                    RtcLineChartCard(
                      line1Data: state.lineChartData.first.line1Data,
                      line2Data: state.lineChartData.first.line2Data,
                    ),

                  // Pie Chart Card #1
                  RtcPieChartCard(
                    title: state.pieChart1Title,
                    data: state.pieChart1Data,
                  ),

                  // Pie Chart Card #2
                  RtcPieChartCard(
                    title: state.pieChart2Title,
                    data: state.pieChart2Data,
                  ),

                  // Bar Chart Card
                  RtcBarChartCard(
                    title: state.barChartTitle,
                    data: state.barChartData,
                  ),

                  // Recent Orders Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          size: 16,
                          color: Colors.blue,
                        ),
                        // // TODO
                        const Text(
                          'آخرین سفارش‌ها',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black, // // TODO: replace with theme values
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Recent Orders List
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.recentOrders.length,
                    itemBuilder: (context, index) {
                      return RtcOrderItem(
                        order: state.recentOrders[index],
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
          buildWhen: (prev, curr) =>
              prev.selectedNavIndex != curr.selectedNavIndex,
          builder: (context, state) {
            return RtcBottomNav(
              selectedIndex: state.selectedNavIndex,
              onItemSelected: (index) {
                context.read<DashboardCubit>().onNavItemSelected(index);
              },
            );
          },
        ),
      ),
    );
  }
}
