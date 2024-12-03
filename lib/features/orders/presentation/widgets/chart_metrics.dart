import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/chart_config.dart';

class ChartMetrics extends StatelessWidget {
  final List<MapEntry<DateTime, int>> orderData;

  const ChartMetrics({
    super.key,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = _calculateMetrics();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ChartConfig.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Metrics',
            style: ChartConfig.titleStyle(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetricCard(
                'Total Orders',
                metrics.totalOrders.toString(),
                Colors.blue,
              ),
              const SizedBox(width: 8),
              _buildMetricCard(
                'Average Daily',
                metrics.averageDaily.toStringAsFixed(1),
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMetricCard(
                'Peak Orders',
                metrics.peakOrders.toString(),
                Colors.orange,
              ),
              const SizedBox(width: 8),
              _buildMetricCard(
                'Growth Rate',
                '${metrics.growthRate.toStringAsFixed(1)}%',
                metrics.growthRate >= 0 ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.workSans(
                color: Colors.grey[700],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.workSans(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _MetricsData _calculateMetrics() {
    if (orderData.isEmpty) {
      return _MetricsData(
        totalOrders: 0,
        averageDaily: 0,
        peakOrders: 0,
        growthRate: 0,
      );
    }

    final totalOrders = orderData.fold(0, (sum, entry) => sum + entry.value);
    final averageDaily = totalOrders / orderData.length;
    final peakOrders = orderData.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    // Calculate growth rate
    final firstWeekOrders = orderData.take(7).fold(0, (sum, entry) => sum + entry.value);
    final lastWeekOrders = orderData.skip(orderData.length - 7).fold(0, (sum, entry) => sum + entry.value);
    final growthRate = firstWeekOrders > 0
        ? ((lastWeekOrders - firstWeekOrders) / firstWeekOrders) * 100
        : 0.0;

    return _MetricsData(
      totalOrders: totalOrders,
      averageDaily: averageDaily,
      peakOrders: peakOrders,
      growthRate: growthRate,
    );
  }
}

class _MetricsData {
  final int totalOrders;
  final double averageDaily;
  final int peakOrders;
  final double growthRate;

  _MetricsData({
    required this.totalOrders,
    required this.averageDaily,
    required this.peakOrders,
    required this.growthRate,
  });
}
