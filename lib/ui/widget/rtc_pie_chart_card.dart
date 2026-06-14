import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/pie_chart_item_model.dart';
import '../theme/colors.dart';

import '../widget/rtc_image.dart';

class RtcPieChartCard extends StatefulWidget {
  final String title;
  final List<PieChartItemModel> data;
  final String? emptyMessage;
  final String? emptyImage;

  const RtcPieChartCard({
    super.key,
    required this.title,
    required this.data,
    this.emptyMessage,
    this.emptyImage,
  });

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
        width: double.infinity,
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
              if (total == 0 && widget.emptyMessage != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.emptyImage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 13.5),
                          child: RtcImage(
                            image: widget.emptyImage!,
                            width: 143,
                            height: 124,
                          ),
                        ),
                      Text(
                        widget.emptyMessage!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.grayPalette.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              else
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
                                        pieTouchResponse.touchedSection ==
                                            null) {
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
                          sections: total == 0
                              ? [
                                  PieChartSectionData(
                                    color: AppColors.grayPalette.shade200,
                                    value: 1,
                                    radius: 21.0,
                                    showTitle: false,
                                  ),
                                ]
                              : widget.data.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final item = entry.value;
                                  final isTouched = index == touchedIndex;
                                  final radius = isTouched ? 30.0 : 21.0;

                                  // Calculate percentage
                                  final percentage = total > 0
                                      ? (item.value / total * 100)
                                            .toStringAsFixed(0)
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
              if (total != 0 || widget.emptyMessage == null)
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
            NumberFormat('#,###').format(item.value.toInt()),
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
