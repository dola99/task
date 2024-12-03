import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/features/orders/presentation/pages/orders_screen.dart';
import 'features/orders/presentation/cubit/orders_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.workSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: BlocProvider(
        create: (context) => OrdersCubit()..loadOrders(),
        child: const OrdersScreen(),
      ),
    );
  }
}
