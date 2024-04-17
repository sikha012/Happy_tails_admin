import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final int currentValue;
  final bool? disablePreviousValue;
  final String? replacementValue;
  final int? previousValue;
  final IconData icon;
  final Color iconColor;
  final String linkText;
  final VoidCallback? onLinkTap;

  const StatisticCard({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.previousValue,
    required this.icon,
    required this.iconColor,
    required this.linkText,
    this.onLinkTap,
    this.disablePreviousValue = false,
    this.replacementValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentChange =
        _calculatePercentageChange(currentValue, previousValue ?? 0);
    final changeColor = percentChange == 0
        ? Colors.black
        : percentChange < 0
            ? Colors.red
            : Colors.green;

    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 300,
        height: 183,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currentValue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                ),
              ],
            ),
            SizedBox(height: 4.0),
            disablePreviousValue!
                ? Text(
                    replacementValue ?? '',
                    style: TextStyle(fontSize: 12),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${percentChange.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: changeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            changeColor == Colors.red
                                ? Icons.trending_down
                                : Icons.trending_up,
                            color: changeColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'This month: $currentValue',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Last month: $previousValue',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: onLinkTap,
              child: Text(
                linkText,
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculatePercentageChange(int currentValue, int previousValue) {
    if (previousValue == 0) return 0.0;
    return ((currentValue - previousValue) / previousValue) * 100;
  }
}
