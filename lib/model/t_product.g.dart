// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      uniqueId: json['uniqueId'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      currentPrice: json['currentPrice'] as String?,
      category:
          ProductCategory.fromJson(json['category'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      isInWishList: json['isInWishList'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'uniqueId': instance.uniqueId,
      'isAvailable': instance.isAvailable,
      'imageUrl': instance.imageUrl,
      'currentPrice': instance.currentPrice,
      'quantity': instance.quantity,
      'isInWishList': instance.isInWishList,
      'category': instance.category,
    };
