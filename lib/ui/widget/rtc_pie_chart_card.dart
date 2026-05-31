import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/pie_chart_item_model.dart';
import '../theme/colors.dart';

class RtcPieChartCard extends StatelessWidget {
  final String title;
  final List<PieChartItemModel> data;

  const RtcPieChartCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.primaryShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                spacing: 31,
                children: [
                  Expanded(
                    child: Column(
                      children: data
                          .map((item) => _buildLegendItem(item, textTheme))
                          .toList(),
                    ),
                  ),

                  SizedBox(
                    width: 142,
                    height: 142,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        sections: data.map((item) {
                          return PieChartSectionData(
                            color: item.color,
                            value: item.value,
                            radius: 21,
                            showTitle: false,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 19),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(PieChartItemModel item, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            item.label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          const Spacer(),

          Text(
            item.value.toInt().toString(),
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
