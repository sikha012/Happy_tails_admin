import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:happy_admin/app/utils/constants.dart';

class DraftPieChartScreen extends StatefulWidget {
  final double ratio;
  final double currentMonthSales;
  final double previousMonthSales;
  final double twoMonthsAgoSales;

  const DraftPieChartScreen({
    Key? key,
    required this.ratio,
    required this.currentMonthSales,
    required this.previousMonthSales,
    required this.twoMonthsAgoSales,
  }) : super(key: key);

  @override
  State<DraftPieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<DraftPieChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: widget.ratio,
            child: PieChart(
              swapAnimationCurve: Curves.bounceIn,
              swapAnimationDuration: Duration(milliseconds: 300),
              PieChartData(
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: [
                  PieChartSectionData(
                    value: widget.twoMonthsAgoSales,
                    color: Constants.tertiaryColor,
                    title: '${widget.twoMonthsAgoSales.toInt()}',
                    radius: 140,
                    titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff)),
                    showTitle: true, // Display title inside the section
                  ),
                  PieChartSectionData(
                    value: widget.previousMonthSales,
                    color: Constants.primaryColor,
                    title: '${widget.previousMonthSales.toInt()}',
                    radius: 140,
                    titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff)),
                    showTitle: true, // Display title inside the section
                  ),
                  PieChartSectionData(
                    value: widget.currentMonthSales,
                    color: Colors.green,
                    title: '${widget.currentMonthSales.toInt()}',
                    radius: 140,
                    titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff)),
                    showTitle: true, // Display title inside the section
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Two Months Ago', Constants.tertiaryColor),
              SizedBox(width: 16),
              _buildLegendItem('Previous Month', Constants.primaryColor),
              SizedBox(width: 16),
              _buildLegendItem('Current Month', Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
