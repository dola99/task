import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/date_helper.dart';
import '../../domain/models/order.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      emit(OrdersLoading());
      
      // Load and parse JSON file
      final String jsonString = await rootBundle.loadString('assets/orders.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      // Convert JSON to Order objects
      final orders = jsonList.map((json) => Order.fromJson(json)).toList();
      
      // Process orders into date-grouped data
      final orderData = _processOrderData(orders);
      final months = DateHelper.getAvailableMonths(orderData.map((e) => e.key).toList());
      final currentMonth = months.isNotEmpty ? months.last : '';

      emit(OrdersLoaded(
        orderData: orderData,
        selectedMonth: currentMonth,
        availableMonths: months,
      ));
    } catch (e) {
      emit(OrdersError('Failed to load orders: $e'));
    }
  }

  void filterByMonth(String month) {
    final currentState = state;
    if (currentState is OrdersLoaded) {
      final filteredData = _filterDataByMonth(currentState.orderData, month);
      emit(OrdersLoaded(
        orderData: filteredData,
        selectedMonth: month,
        availableMonths: currentState.availableMonths,
      ));
    }
  }

  List<MapEntry<DateTime, int>> _processOrderData(List<Order> orders) {
    if (orders.isEmpty) return [];
    
    // Group orders by date
    final Map<DateTime, int> ordersByDate = {};
    for (final order in orders) {
      final date = DateTime(
        order.registered.year,
        order.registered.month,
        order.registered.day,
      );
      ordersByDate[date] = (ordersByDate[date] ?? 0) + 1;
    }

    // Convert to list and sort by date
    final sortedOrders = ordersByDate.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sortedOrders;
  }

  List<MapEntry<DateTime, int>> _filterDataByMonth(
    List<MapEntry<DateTime, int>> data,
    String month,
  ) {
    return data.where((entry) {
      final orderMonth = DateHelper.formatMonth(entry.key);
      return orderMonth == month;
    }).toList();
  }
}
