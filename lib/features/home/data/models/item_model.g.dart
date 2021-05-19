// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    document_id: json['document_id'] as int?,
    name: json['name'] as String?,
    category: json['category'] as String?,
    sub_category: json['sub_category'] as String?,
    description: json['description'] as String?,
    availability: json['availability'] as bool?,
    discounted_price: json['discounted_price'] as String?,
    price: json['price'] as String?,
    tags: json['tags'] as String?,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'document_id': instance.document_id,
      'name': instance.name,
      'category': instance.category,
      'sub_category': instance.sub_category,
      'description': instance.description,
      'availability': instance.availability,
      'discounted_price': instance.discounted_price,
      'price': instance.price,
      'tags': instance.tags,
    };
