// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  @JsonKey(name: "title")
  String itemName;
  String description;
  @JsonKey(name: "picture")
  String imageUrl;
  String unit;
  double price;

  ItemModel({
    this.id = "",
    required this.itemName,
    required this.description,
    required this.imageUrl,
    required this.unit,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, description: $description, imageUrl: $imageUrl, unit: $unit, price: $price)';
  }
}
