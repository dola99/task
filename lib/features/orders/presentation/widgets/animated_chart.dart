import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utils/chart_config.dart';
import 'chart_tooltip.dart';
import 'month_filter.dart';

class AnimatedChart extends StatelessWidget {
  final List<MapEntry<DateTime, int>> orderData;
  final String selectedMonth;
  final List<String> availableMonths;
  final Function(String) onMonthSelected;

  const AnimatedChart({
    super.key,
    required this.orderData,
    required this.selectedMonth,
    required this.availableMonths,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Orders Timeline',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                MonthFilter(
                  selectedMonth: selectedMonth,
                  availableMonths: availableMonths,
                  onMonthSelected: onMonthSelected,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                legend: Legend(isVisible: false),
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.MMMd(),
                  majorGridLines: const MajorGridLines(width: 0),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
                primaryYAxis: NumericAxis(
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    final entry = orderData[pointIndex];
                    return ChartTooltip(
                      date: entry.key,value: entry.value,
                    
                    );
                  },
                ),
                series: <CartesianSeries>[
                  SplineAreaSeries<MapEntry<DateTime, int>, DateTime>(
                    dataSource: orderData,
                    xValueMapper: (entry, _) => entry.key,
                    yValueMapper: (entry, _) => entry.value,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.3),
                        Theme.of(context).primaryColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                  SplineSeries<MapEntry<DateTime, int>, DateTime>(
                    dataSource: orderData,
                    xValueMapper: (entry, _) => entry.key,
                    yValueMapper: (entry, _) => entry.value,
                    color: Theme.of(context).primaryColor,
                    width: 3,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 8,
                      width: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
