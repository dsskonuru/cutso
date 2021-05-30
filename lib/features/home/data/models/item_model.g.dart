// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    sub_category: json['sub_category'] as String,
    description: json['description'] as String?,
    availability: json['availability'] as bool,
    discounted_price: json['discounted_price'] as String?,
    price: json['price'] as String,
    sizes: json['sizes'] as String?,
    preferred_pieces: json['preferred_pieces'] as String?,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'sub_category': instance.sub_category,
      'description': instance.description,
      'availability': instance.availability,
      'discounted_price': instance.discounted_price,
      'price': instance.price,
      'sizes': instance.sizes,
      'preferred_pieces': instance.preferred_pieces,
    };
