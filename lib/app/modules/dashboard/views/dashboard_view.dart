import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Add profile functionality
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Placeholder for statistic cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    List.generate(3, (index) => _buildStatisticCard(index)),
              ),
            ),
            const SizedBox(height: 20),
            // Sales statistics graph
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barGroups: List.generate(7, (index) => _buildBarGroup(index)),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: _getTitlesWidget,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // List of top countries
            _buildTopCountries(),
            const SizedBox(height: 20),
            // List of latest orders
            _buildLatestOrders(),
          ],
        ),
      ),
    );
  }

  Widget _getTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(titles[value.toInt()], style: style),
    );
  }

  BarChartGroupData _buildBarGroup(int x) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: (x + 1) * 5.0, color: Colors.lightBlueAccent),
      ],
    );
  }

  Widget _buildStatisticCard(int index) {
    // Placeholder for a statistic card
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Statistic ${index + 1}'),
            const SizedBox(height: 4),
            Text('${(index + 1) * 1000} units'),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCountries() {
    // Placeholder for top countries list
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: 4, // Dummy data count
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.flag),
            title: Text('Country ${(index + 65).toChar()}'), // A, B, C, D...
            trailing: Text('\$${(index + 1) * 750}.00'),
          );
        },
      ),
    );
  }

  Widget _buildLatestOrders() {
    // Placeholder for latest orders list
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: 4, // Dummy data count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order ${(index + 1) * 100}'),
            subtitle: Text('2024-04-${10 + index}'),
            trailing:
                Text(['Pending', 'Shipped', 'Delivered', 'Cancelled'][index]),
          );
        },
      ),
    );
  }
}

extension on int {
  String toChar() => String.fromCharCode(this);
}
