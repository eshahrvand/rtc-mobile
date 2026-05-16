import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../../widget/rtc_appbar.dart';
import 'bloc/customers_cubit.dart';
import 'bloc/customers_state.dart';
import 'widget/customers_detail_view.dart';
import 'widget/customers_list_view.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomersCubit()..init(),
      child: const CustomersView(),
    );
  }
}

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: RtcAppBar(
            title: state.step == CustomersStep.customerList ? S.current.myCustomers : S.current.customerDetails,
            onBack: () {
              if (state.step == CustomersStep.customerList) {
                context.pop();
              } else {
                context.read<CustomersCubit>().backToList();
              }
            },
            backIconPath: state.step == CustomersStep.customerList 
                ? '$baseImage/angle-right.svg' 
                : '$baseImage/angle-right.svg', // Both use back arrow
          ),
          body: state.step == CustomersStep.customerList
              ? const CustomersListView()
              : const CustomersDetailView(),
        );
      },
    );
  }
}
