import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              tabs: const ['اطلاعات مشتری', 'سفارش‌ها'],
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
          _buildField('نام مشتری', customer.name),
          _buildField('کد ملی', customer.nationalCode),
          _buildField('شماره موبایل', customer.phoneNumber),
          _buildField('کد پستی', customer.postalCode),
          _buildField('آدرس', customer.address),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              // TODO: replace with theme color
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          RtcTextField(
            readOnly: true,
            controller: TextEditingController(text: value),
          ),
        ],
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
