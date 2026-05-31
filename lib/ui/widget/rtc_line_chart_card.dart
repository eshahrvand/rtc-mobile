import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
    final now = Jalali.now();
    final monthLength = now.monthLength;

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
                      color: AppColors.successPalette.shade400,
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
                  minX: 0,
                  maxX: monthLength.toDouble(),
                  minY: 0,
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
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const SizedBox.shrink();
                          String text = '';
                          if (value >= 1000000) {
                            text = '${(value / 1000000).toStringAsFixed(0)}M';
                          } else if (value >= 1000) {
                            text = '${(value / 1000).toStringAsFixed(0)}K';
                          } else {
                            text = value.toStringAsFixed(0);
                          }
                          return Text(
                            text,
                            style: theme.bodySmall!.copyWith(fontSize: 9),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final day = value.toInt();
                          if (day == 1 ||
                              day == 10 ||
                              day == 20 ||
                              day == monthLength) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                day.toString(),
                                style: theme.bodySmall!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: line1Data,
                      isCurved: true,
                      color: AppColors.successPalette.shade400,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      preventCurveOverShooting: true,
                      curveSmoothness: 0.35,
                    ),
                    LineChartBarData(
                      spots: line2Data,
                      isCurved: true,
                      color: AppColors.brandPalette.shade600,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      preventCurveOverShooting: false,
                      preventCurveOvershootingThreshold: 10,
                      curveSmoothness: 0.1,
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
