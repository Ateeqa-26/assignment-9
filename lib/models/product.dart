class Product {
  final String? id;
  final String name;
  final double price;
  const Product({this.id, required this.name, required this.price});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"] as String?,
      name: json["name"] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {'name': name, 'price': price};
  Product copyWith({String? id, String? name, double? price}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}
