import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../models/order_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  @override
  Future<List<Order>> getOrders() async {
    try {
      final String response = await rootBundle.loadString('assets/orders.json');
      final List<dynamic> jsonData = json.decode(response);
      return jsonData.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
