import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/bar_chart_item_model.dart';
import '../theme/colors.dart';

class RtcBarChartCard extends StatelessWidget {
  final String title;
  final List<BarChartItemModel> data;

  const RtcBarChartCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final double maxDataValue = data.isEmpty
        ? 0
        : data
              .map((e) => e.value)
              .reduce((curr, next) => curr > next ? curr : next);
    final double maxY = maxDataValue == 0 ? 10 : maxDataValue * 1.2;

    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
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
                textAlign: TextAlign.right,
                style: theme.labelLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 1.8,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) =>
                            AppColors.brandPalette.shade600,
                        tooltipRoundedRadius: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final formatter = NumberFormat('#,###');
                          return BarTooltipItem(
                            formatter.format(rod.toY.toInt()),
                            theme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < data.length) {
                              return SideTitleWidget(
                                meta: meta,
                                space: 8,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    data[index].label,
                                    style: theme.bodySmall!.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 80,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: data.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value.value,
                            color: AppColors.brandPalette.shade600,
                            width: 20,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(1),
                              topRight: Radius.circular(1),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
