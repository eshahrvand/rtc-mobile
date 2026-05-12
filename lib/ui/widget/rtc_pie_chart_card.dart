import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/pie_chart_item_model.dart';

class RtcPieChartCard extends StatelessWidget {
  final String title;
  final List<PieChartItemModel> data;

  const RtcPieChartCard({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // // TODO: replace with theme values
        borderRadius: BorderRadius.circular(16), // // TODO: replace with theme values
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // // TODO: replace with theme values
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black, // // TODO: replace with theme values
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: data.map((item) => _buildLegendItem(item)).toList(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 35,
                      sections: data.map((item) {
                        return PieChartSectionData(
                          color: item.color,
                          value: item.value,
                          radius: 20,
                          showTitle: false,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(PieChartItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            item.value.toInt().toString(),
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          const Spacer(),
          Text(
            item.label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
