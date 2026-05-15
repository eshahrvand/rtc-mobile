import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_customer_item.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

class CustomersListView extends StatelessWidget {
  const CustomersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RtcTextField(
                labelText: 'جستجو',
                onChanged: (value) =>
                    context.read<CustomersCubit>().onSearchChanged(value),
                suffix: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: state.status == CustomersRequestStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: state.filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = state.filteredCustomers[index];
                        return RtcCustomerItem(
                          customer: customer,
                          onTap: () => context
                              .read<CustomersCubit>()
                              .onCustomerTapped(customer),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
