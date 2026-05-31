import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/pie_chart_item_model.dart';
import '../theme/colors.dart';

class RtcPieChartCard extends StatefulWidget {
  final String title;
  final List<PieChartItemModel> data;

  const RtcPieChartCard({super.key, required this.title, required this.data});

  @override
  State<RtcPieChartCard> createState() => _RtcPieChartCardState();
}

class _RtcPieChartCardState extends State<RtcPieChartCard> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final total = widget.data.fold<double>(0, (sum, item) => sum + item.value);

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
                widget.title,
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
                      children: widget.data.asMap().entries.map((entry) {
                        return _buildLegendItem(entry.value, textTheme);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 142,
                    height: 142,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!
                                      .touchedSectionIndex;
                                });
                              },
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        sections: widget.data.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isTouched = index == touchedIndex;
                          final radius = isTouched ? 30.0 : 21.0;

                          // Calculate percentage
                          final percentage = total > 0
                              ? (item.value / total * 100).toStringAsFixed(0)
                              : '0';

                          return PieChartSectionData(
                            color: item.color,
                            value: item.value,
                            radius: radius,
                            showTitle: isTouched,
                            title: '$percentage%',
                            titleStyle: textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
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
