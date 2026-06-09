import 'package:flutter/material.dart';
import '../../../widget/rtc_quick_access_item.dart';
import '../bloc/dashboard_state.dart';

class DashboardQuickAccessGrid extends StatelessWidget {
  final List<dynamic> items;

  const DashboardQuickAccessGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12.0,
          children: [
            if (items.length > 1)
              RtcQuickAccessItem(
                title: items[1].title,
                value: items[1].value,
                currency: items[1].currency,
                iconPath: items[1].iconPath,
                percentage: items[1].percentage,
                onTap: () {},
              ),
            if (items.isNotEmpty)
              RtcQuickAccessItem(
                title: items[0].title,
                value: items[0].value,
                currency: items[0].currency,
                iconPath: items[0].iconPath,
                percentage: items[0].percentage,
                onTap: () {},
              ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          spacing: 12.0,
          children: [
            if (items.length > 3)
              RtcQuickAccessItem(
                title: items[3].title,
                value: items[3].value,
                currency: items[3].currency,
                iconPath: items[3].iconPath,
                percentage: items[3].percentage,
                onTap: () {},
              ),
            if (items.length > 2)
              RtcQuickAccessItem(
                title: items[2].title,
                value: items[2].value,
                currency: items[2].currency,
                iconPath: items[2].iconPath,
                percentage: items[2].percentage,
                onTap: () {},
              ),
          ],
        ),
      ],
    );
  }
}
