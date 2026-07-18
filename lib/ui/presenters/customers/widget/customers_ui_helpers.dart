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
    ScrollController? scrollController,
  }) {
    if (state.status == CustomersRequestStatus.loading &&
        state.allCustomers.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.filteredCustomers.isEmpty) {
      return Center(
        child: Text(
          S.current.noItemsFound,
          style: theme.bodyLarge?.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount:
          state.filteredCustomers.length + (state.isPaginationLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.filteredCustomers.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final customer = state.filteredCustomers[index];
        return RtcCustomerItem(
          customer: customer,
          onTap: () =>
              context.read<CustomersCubit>().onCustomerTapped(customer),
        );
      },
    );
  }
}
