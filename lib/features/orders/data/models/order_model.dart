import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.isActive,
    required super.price,
    required super.company,
    required super.picture,
    required super.buyer,
    required super.tags,
    required super.status,
    required super.registered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      isActive: json['isActive'],
      price: _parsePrice(json['price']),
      company: json['company'],
      picture: json['picture'],
      buyer: json['buyer'],
      tags: List<String>.from(json['tags']),
      status: OrderStatus.fromString(json['status']),
      registered: DateTime.parse(json['registered']),
    );
  }

  static double _parsePrice(String priceStr) {
    return double.parse(
      priceStr.replaceAll('\$', '').replaceAll(',', ''),
    );
  }
}
