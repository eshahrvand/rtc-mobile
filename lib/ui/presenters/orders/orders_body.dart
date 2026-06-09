import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/orders_cubit.dart';
import 'bloc/orders_state.dart';
import 'widget/orders_badge_list.dart';
import 'widget/orders_ui_helpers.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              OrdersBadgeList(state: state),
              Expanded(
                child: OrdersUiHelpers.resolveOrdersListBody(
                  context: context,
                  state: state,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
