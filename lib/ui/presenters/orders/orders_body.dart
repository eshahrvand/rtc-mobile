import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/orders_cubit.dart';
import 'bloc/orders_state.dart';
import 'widget/orders_badge_list.dart';
import 'widget/orders_ui_helpers.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<OrdersCubit>().fetchNextPage();
    }
  }

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
                  scrollController: _scrollController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
