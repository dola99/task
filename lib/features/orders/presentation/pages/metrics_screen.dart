import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/date_helper.dart';
import '../cubit/orders_cubit.dart';

class MetricsScreen extends StatelessWidget {
  const MetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is! OrdersLoaded) {
          return const SizedBox.shrink();
        }

        final metrics = _calculateMetrics(state.orderData);

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Key Metrics',
                style: GoogleFonts.workSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _MetricCard(
                    title: 'Total Orders',
                    value: metrics.totalOrders.toString(),
                    icon: Icons.shopping_cart,
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                  ),
                  _MetricCard(
                    title: 'Daily Average',
                    value: metrics.dailyAverage.toStringAsFixed(1),
                    icon: Icons.trending_up,
                    gradient: const LinearGradient(
                      colors: [Colors.green, Colors.greenAccent],
                    ),
                  ),
                  _MetricCard(
                    title: 'Peak Orders',
                    value: metrics.peakOrders.toString(),
                    icon: Icons.bar_chart,
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.purpleAccent],
                    ),
                  ),
                  _MetricCard(
                    title: 'Growth Rate',
                    value: '${metrics.growthRate.toStringAsFixed(1)}%',
                    icon: metrics.growthRate >= 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    gradient: LinearGradient(
                      colors: metrics.growthRate >= 0
                          ? [Colors.green, Colors.greenAccent]
                          : [Colors.red, Colors.redAccent],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _MetricsData _calculateMetrics(List<MapEntry<DateTime, int>> orderData) {
    if (orderData.isEmpty) {
      return _MetricsData(
        totalOrders: 0,
        dailyAverage: 0,
        peakOrders: 0,
        growthRate: 0,
      );
    }

    final totalOrders = orderData.fold(0, (sum, entry) => sum + entry.value);
    final dailyAverage = totalOrders / orderData.length;
    final peakOrders = orderData.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final firstWeekOrders = orderData.take(7).fold(0, (sum, entry) => sum + entry.value);
    final lastWeekOrders = orderData.skip(orderData.length - 7).fold(0, (sum, entry) => sum + entry.value);
    final growthRate = DateHelper.calculateGrowthRate(firstWeekOrders, lastWeekOrders);

    return _MetricsData(
      totalOrders: totalOrders,
      dailyAverage: dailyAverage,
      peakOrders: peakOrders,
      growthRate: growthRate,
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.workSans(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricsData {
  final int totalOrders;
  final double dailyAverage;
  final int peakOrders;
  final double growthRate;

  _MetricsData({
    required this.totalOrders,
    required this.dailyAverage,
    required this.peakOrders,
    required this.growthRate,
  });
}
