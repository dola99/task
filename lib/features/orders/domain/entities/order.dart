import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final OrderStatus status;
  final DateTime registered;

  const Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  @override
  List<Object?> get props => [
        id,
        isActive,
        price,
        company,
        picture,
        buyer,
        tags,
        status,
        registered,
      ];
}

enum OrderStatus {
  ordered('ORDERED'),
  delivered('DELIVERED'),
  returned('RETURNED');

  final String value;
  const OrderStatus(this.value);

  factory OrderStatus.fromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => OrderStatus.ordered,
    );
  }
}
