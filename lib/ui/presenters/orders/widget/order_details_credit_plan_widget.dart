import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_collapsible_section.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_details_credit_plan_info.dart';

class OrderDetailsCreditPlanWidget extends StatelessWidget {
  final OrderDetailModel order;

  const OrderDetailsCreditPlanWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        // Credit plan section
        return RtcCollapsibleSection(
          title: S.current.creditPlanTitle,
          icon: RtcImage(
            image: '$baseImage/referee-card.svg',
            width: 18,
            height: 18,
            color: AppColors.grayPalette.shade700,
          ),
          isExpanded: state.isCreditPlanExpanded,
          onToggle: () => cubit.toggleCreditPlan(),
          trailing: RtcImage(
            image: state.isCreditPlanExpanded
                ? "$baseImage/arrow_up_tab.svg"
                : "$baseImage/angle-down_tab.svg",
            width: 24,
            height: 24,
            color: AppColors.grayPalette.shade600,
          ),
          child: order.creditPlan == null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(S.current.noPlanSelected),
                )
              : OrderDetailsCreditPlanInfo(plan: order.creditPlan!),
        );
      },
    );
  }
}
