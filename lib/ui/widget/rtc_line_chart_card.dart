import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../theme/colors.dart';

class RtcLineChartCard extends StatelessWidget {
  final List<FlSpot> line1Data;
  final List<FlSpot> line2Data;
  final String? line1Label;
  final String? line2Label;

  const RtcLineChartCard({
    super.key,
    required this.line1Data,
    required this.line2Data,
    this.line1Label,
    this.line2Label,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.primaryShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.dailySalesChart,
                  style: theme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
                Row(
                  spacing: 8,
                  children: [
                    _buildLegendItem(
                      label: line1Label ?? S.current.lastMonth,
                      color: AppColors.successPalette.shade500,
                      theme: theme,
                    ),
                    _buildLegendItem(
                      label: line2Label ?? S.current.currentMonth,
                      color: AppColors.brandPalette.shade600,
                      theme: theme,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.8,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Color(0xFFF2F4F7),
                        // // TODO: replace with theme values
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              // // TODO: replace with theme values
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: line1Data,
                      isCurved: true,
                      color: Colors.green,
                      // // TODO: replace with theme values
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: line2Data,
                      isCurved: true,
                      color: Colors.blue,
                      // // TODO: replace with theme values
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required String label,
    required Color color,
    required TextTheme theme,
  }) {
    return Row(
      spacing: 6,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(
          label,
          style: theme.bodySmall!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
      ],
    );
  }
}
