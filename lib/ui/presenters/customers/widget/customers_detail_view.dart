import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

import 'customers_info_tab.dart';
import 'customers_orders_tab.dart';

class CustomersDetailView extends StatefulWidget {
  const CustomersDetailView({super.key});

  @override
  State<CustomersDetailView> createState() => _CustomersDetailViewState();
}

class _CustomersDetailViewState extends State<CustomersDetailView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialIndex = context.read<CustomersCubit>().state.selectedTabIndex;
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        if (state.selectedCustomer == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return MultiBlocListener(
          listeners: [
            BlocListener<CustomersCubit, CustomersState>(
              listenWhen: (prev, curr) =>
                  prev.selectedTabIndex != curr.selectedTabIndex,
              listener: (context, state) {
                if (_pageController.hasClients &&
                    _pageController.page?.toInt() != state.selectedTabIndex) {
                  _pageController.animateToPage(
                    state.selectedTabIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
          child: Container(
            color: AppColors.grayPalette.shade25,
            child: Column(
              children: [
                RtcTabBar(
                  tabs: [S.current.customerInfo, S.current.orders],
                  selectedIndex: state.selectedTabIndex,
                  onTabChanged: (index) =>
                      context.read<CustomersCubit>().onTabChanged(index),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        context.read<CustomersCubit>().onTabChanged(index),
                    children: [
                      CustomersInfoTab(customer: state.selectedCustomer!),
                      CustomersOrdersTab(
                        orders: state.selectedCustomer!.orders,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
