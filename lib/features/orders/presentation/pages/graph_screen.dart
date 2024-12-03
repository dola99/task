import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/animated_chart.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading orders data',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    color: Colors.red[400],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<OrdersCubit>().loadOrders();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is OrdersLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Orders Analytics',
                  style: GoogleFonts.workSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: AnimatedChart(
                    orderData: state.orderData,
                    selectedMonth: state.selectedMonth,
                    availableMonths: state.availableMonths,
                    onMonthSelected: (month) {
                      context.read<OrdersCubit>().filterByMonth(month);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Center(
          child: Text(
            'No data available',
            style: GoogleFonts.workSans(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        );
      },
    );
  }
}
