class Order {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String buyer;
  final List<String> tags;
  final String status;
  final DateTime registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      isActive: json['isActive'] as bool,
      price: double.parse(json['price'].toString().replaceAll(r'$', '').replaceAll(',', '')),
      company: json['company'] as String,
      buyer: json['buyer'] as String,
      tags: List<String>.from(json['tags']),
      status: json['status'] as String,
      registered: DateTime.parse(json['registered']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
      'price': price,
      'company': company,
      'buyer': buyer,
      'tags': tags,
      'status': status,
      'registered': registered.toIso8601String(),
    };
  }
}
