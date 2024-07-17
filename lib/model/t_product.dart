import 'dart:convert';


class Items {
  final String id;
  final String? name;
  final String? description;
  final String? uniqueId;

  final bool? isAvailable;
  final String? imageUrl;
  final String? currentPrice;
  final int quantity;

  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.uniqueId,
    required this.isAvailable,
    required this.imageUrl,
    required this.currentPrice,
    this.quantity = 1,
  });

  @override
  String toString() {
    return 'Items(id: $id name: $name, description: $description, uniqueId: $uniqueId, isAvailable: $isAvailable, imageUrl: $imageUrl, currentPrice: $currentPrice)';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'uniqueId': uniqueId,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'currentPrice': currentPrice,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      uniqueId: map['uniqueId'],
      isAvailable: map['isAvailable'],
      imageUrl: map['photos'][0]['url'],
      currentPrice: map['current_price'][0]['NGN'][0].toString(),
      // quantity: 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) => Items.fromMap(json.decode(source));

  Items copyWith({
    String? id,
    String? name,
    String? description,
    String? uniqueId,
    bool? isAvailable,
    String? imageUrl,
    String? currentPrice,
    int? quantity,
  }) {
    return Items(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      uniqueId: uniqueId ?? this.uniqueId,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
