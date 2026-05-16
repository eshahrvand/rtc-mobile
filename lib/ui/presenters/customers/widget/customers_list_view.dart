import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../widget/rtc_customer_item.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

class CustomersListView extends StatelessWidget {
  const CustomersListView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16 , 10 , 16, 10),
              child: RtcTextField(
                hintText: S.current.search,
                hintStyle: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade400,
                ),
                onChanged: (value) =>
                    context.read<CustomersCubit>().onSearchChanged(value),
                prefix: RtcImage(image: "$baseImage/search.svg"),
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
