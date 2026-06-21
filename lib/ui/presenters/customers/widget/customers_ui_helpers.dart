import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_customer_item.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersUiHelpers {
  /// Returns the appropriate widget for the customer list body based on the current state.
  static Widget resolveListBody({
    required BuildContext context,
    required CustomersState state,
    required TextTheme theme,
  }) {
    return switch (state.status) {
      CustomersRequestStatus.loading => const Center(
        child: CircularProgressIndicator(),
      ),
      _ =>
        state.filteredCustomers.isEmpty
            ? Center(
                child: Text(
                  S.current.noItemsFound,
                  style: theme.bodyLarge?.copyWith(
                    color: AppColors.grayPalette.shade600,
                  ),
                ),
              )
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
    };
  }
}
