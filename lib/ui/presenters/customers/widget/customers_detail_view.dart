import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:go_router/go_router.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_customer_order_item.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

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
          child: Column(
            children: [
              RtcTabBar(
                tabs: [S.current.customerInfo, S.current.orders],
                selectedIndex: state.selectedTabIndex,
                onTabChanged: (index) =>
                    context.read<CustomersCubit>().onTabChanged(index),
              ),
              SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      context.read<CustomersCubit>().onTabChanged(index),
                  children: [
                    _CustomerInfoTab(customer: state.selectedCustomer!),
                    _CustomerOrdersTab(orders: state.selectedCustomer!.orders),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CustomerInfoTab extends StatelessWidget {
  final dynamic customer;

  const _CustomerInfoTab({required this.customer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildField(S.current.customerName, customer.name, context),
          _buildField(S.current.nationalId, customer.nationalCode, context),
          _buildField(S.current.phoneNumber, customer.phoneNumber, context),
          _buildField(S.current.postalCode, customer.postalCode, context),
          _buildField(S.current.address, customer.address, context),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: RtcTextField(
        readOnly: true,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.grayPalette.shade700,
        ),
        controller: TextEditingController(text: value),
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.grayPalette.shade700),
      ),
    );
  }
}

class _CustomerOrdersTab extends StatelessWidget {
  final List<dynamic> orders;

  const _CustomerOrdersTab({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return RtcCustomerOrderItem(
            order: order,
            onTap: () {
              context.push(AppRoutes.orderDetail, extra: order.orderId);
            },
          );
        },
      ),
    );
  }
}
