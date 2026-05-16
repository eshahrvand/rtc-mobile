import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../widget/rtc_customer_order_item.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

class CustomersDetailView extends StatelessWidget {
  const CustomersDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        if (state.selectedCustomer == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            RtcTabBar(
              tabs: [S.current.customerInfo, S.current.orders],
              selectedIndex: state.selectedTabIndex,
              onTabChanged: (index) =>
                  context.read<CustomersCubit>().onTabChanged(index),
            ),
            Expanded(
              child: IndexedStack(
                index: state.selectedTabIndex,
                children: [
                  _CustomerInfoTab(customer: state.selectedCustomer!),
                  _CustomerOrdersTab(orders: state.selectedCustomer!.orders),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.all(16),
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
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.grayPalette.shade700
        ),

      ),
    );
  }
}

class _CustomerOrdersTab extends StatelessWidget {
  final List<dynamic> orders;

  const _CustomerOrdersTab({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return RtcCustomerOrderItem(order: orders[index]);
      },
    );
  }
}
