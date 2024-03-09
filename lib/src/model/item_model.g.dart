// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String? ?? "",
      itemName: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['picture'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.itemName,
      'description': instance.description,
      'picture': instance.imageUrl,
      'unit': instance.unit,
      'price': instance.price,
    };
