// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    itemId: json['itemId'] as int,
    quantity: (json['quantity'] as num).toDouble(),
    tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
    guidelines: json['guidelines'] as String?,
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'tags': instance.tags.toList(),
      'guidelines': instance.guidelines,
      'price': instance.price,
    };
