import 'package:json_annotation/json_annotation.dart';

// class MyJsonConverter extends JsonConverter {
//   @override
//   fromJson(json) {
   
//   }

//   @override
//   toJson(object) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }

// }
part 'product_category.g.dart';
@JsonSerializable()
class ProductCategory {
  final String id;
  final String productCategoryName;

  ProductCategory({required this.id, required this.productCategoryName});

  @override
  String toString() => 'ProductCategory(id: $id, productCategoryName: $productCategoryName)';

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);
   Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
