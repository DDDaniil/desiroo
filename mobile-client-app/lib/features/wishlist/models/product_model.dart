import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String ProductId;
  final String WishlistId;
  final String Name;
  final String Link;
  final String PriceCategory;
  final String GiftImportance;
  final String PhotoPath;

  ProductModel({
    required this.ProductId,
    required this.WishlistId,
    required this.Name,
    required this.Link,
    required this.PriceCategory,
    required this.GiftImportance,
    required this.PhotoPath,
});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}