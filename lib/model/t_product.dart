import 'package:easy_shopper/model/product_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 't_product.g.dart';

@JsonSerializable()
class Items {
  final String id;
  final String? name;
  final String? description;
  final String? uniqueId;

  final bool? isAvailable;
  final String? imageUrl;
  final String? currentPrice;
  final int quantity;
  final bool isInWishList;
  
  final ProductCategory category;

  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.uniqueId,
    required this.isAvailable,
    required this.imageUrl,
    required this.currentPrice,
    required this.category,
    this.quantity = 1,
    this.isInWishList = false,
  });

  @override
  String toString() {
    return 'Items(id: $id name: $name, description: $description, uniqueId: $uniqueId, isAvailable: $isAvailable, imageUrl: $imageUrl, currentPrice: $currentPrice, quantity: $quantity, isInWishlist: $isInWishList, category: $category)';
  }

  Items copyWith(
      {String? id,
      String? name,
      String? description,
      String? uniqueId,
      bool? isAvailable,
      String? imageUrl,
      String? currentPrice,
      int? quantity,
      bool? isInWishList,
      ProductCategory? category,
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
      isInWishList: isInWishList ?? this.isInWishList,
      category: category ?? this.category
    );
  }

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
