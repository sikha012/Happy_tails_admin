import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PieChartScreen extends StatefulWidget {
  final double ratio;
  final String title;
  final Map<String, int> categoryDistribution;

  const PieChartScreen({
    Key? key,
    required this.ratio,
    required this.categoryDistribution,
    required this.title,
  }) : super(key: key);

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  Map<String, Color> categoryColorMap = {};

  @override
  void initState() {
    super.initState();
    categoryColorMap =
        _generateColorsForCategories(widget.categoryDistribution.keys.toList());
  }

  Map<String, Color> _generateColorsForCategories(List<String> categories) {
    final Map<String, Color> colorMap = {};
    final random = Random();
    for (var category in categories) {
      colorMap[category] = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    }
    return colorMap;
  }

  List<PieChartSectionData> _createSections(Map<String, int> distribution) {
    return distribution.keys.map((category) {
      final color = categoryColorMap[category] ?? Colors.grey;
      final value = distribution[category]!.toDouble();
      return PieChartSectionData(
        color: color,
        value: value,
        title: '$value',
        radius: 140,
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
      );
    }).toList();
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections =
        _createSections(widget.categoryDistribution);

    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sectionsSpace: 1,
              sections: sections,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Wrap(
            spacing: 16,
            runSpacing: 5,
            children: widget.categoryDistribution.keys.map((category) {
              return _buildLegendItem(category, categoryColorMap[category]!);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
