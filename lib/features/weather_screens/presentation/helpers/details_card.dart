import 'package:flutter/material.dart';

class WeatherDetailsCard extends StatelessWidget {
  /// ilke: wind speed
  final String weatherDetailMetricName;

  /// 20 kph
  final dynamic weatherDetailValue;

  /// any Icon that describe that detail
  final Icon icon;
  final bool centerIconAndTitle;

  const WeatherDetailsCard({
    super.key,
    required this.weatherDetailMetricName,
    required this.weatherDetailValue,
    required this.icon,
    this.centerIconAndTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade100 : Colors.grey.shade900,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: centerIconAndTitle? MainAxisAlignment.center: MainAxisAlignment.start,
              children: [
                icon,
                SizedBox(
                  width: 5,
                ),
                Text(weatherDetailMetricName),
              ],
            ),
            Text(weatherDetailValue.toString())
          ],
        ),
      ),
    );
  }
}
