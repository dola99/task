import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  final int totalOrders;
  final double averageOrders;

  const ChartLegend({
    super.key,
    required this.totalOrders,
    required this.averageOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _LegendItem(
            icon: Icons.shopping_cart,
            title: 'Total Orders',
            value: totalOrders.toString(),
            color: Colors.blue.shade500,
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade200,
          ),
          _LegendItem(
            icon: Icons.analytics,
            title: 'Average Orders',
            value: averageOrders.toStringAsFixed(1),
            color: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _LegendItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
