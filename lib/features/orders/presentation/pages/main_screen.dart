import 'package:flutter/material.dart';
import 'graph_screen.dart';
import 'metrics_screen.dart';
import 'orders_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
   
    GraphScreen(),
    MetricsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrdersScreen(),
    
    );
  }
}
