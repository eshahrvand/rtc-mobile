import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

                const Text(
                  'نمودار روزانه فروش',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // // TODO: replace with theme values
                  ),
                ),
                Row(
                  children: [
                    _buildLegendItem(line2Label ?? 'ماه جاری', Colors.blue),
                    const SizedBox(width: 12),
                    _buildLegendItem(line1Label ?? 'ماه گذشته', Colors.green),
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 4),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
