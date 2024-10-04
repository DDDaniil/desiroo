import 'package:json_annotation/json_annotation.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel {
  final String Id;
  final String Name;

  WishlistModel({required this.Id, required this.Name});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);
}