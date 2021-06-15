// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$_$_ItemFromJson(Map<String, dynamic> json) {
  return _$_Item(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    subCategory: json['subCategory'] as String,
    availability: json['availability'] as bool,
    price: json['price'] as String,
    description: json['description'] as String?,
    discountedPrice: json['discountedPrice'] as String?,
    sizes: json['sizes'] as String?,
    preferredPieces: json['preferredPieces'] as String?,
  );
}

Map<String, dynamic> _$_$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'availability': instance.availability,
      'price': instance.price,
      'description': instance.description,
      'discountedPrice': instance.discountedPrice,
      'sizes': instance.sizes,
      'preferredPieces': instance.preferredPieces,
    };
