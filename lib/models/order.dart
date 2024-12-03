class Order {
  final String id;
  final bool isActive;
  final String price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final String status;
  final DateTime registered;

  Order({
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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      isActive: json['isActive'] as bool,
      price: json['price'] as String,
      company: json['company'] as String,
      picture: json['picture'] as String,
      buyer: json['buyer'] as String,
      tags: List<String>.from(json['tags']),
      status: json['status'] as String,
      registered: DateTime.parse(json['registered']),
    );
  }

  double get priceValue {
    return double.parse(price.replaceAll('\$', '').replaceAll(',', ''));
  }
}
