// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    subCategory: json['subCategory'] as String,
    description: json['description'] as String?,
    availability: json['availability'] as bool,
    discountedPrice: json['discountedPrice'] as String?,
    price: json['price'] as String,
    sizes: json['sizes'] as String?,
    preferredPieces: json['preferredPieces'] as String?,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'description': instance.description,
      'availability': instance.availability,
      'discountedPrice': instance.discountedPrice,
      'price': instance.price,
      'sizes': instance.sizes,
      'preferredPieces': instance.preferredPieces,
    };
