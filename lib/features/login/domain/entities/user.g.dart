// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    name: json['name'] as String,
    location: Address._fromJsonGeoPoint(json['location'] as GeoPoint),
    line: json['line'] as String,
    landmark: json['landmark'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'line': instance.line,
      'landmark': instance.landmark,
      'location': Address._toJsonGeoPoint(instance.location),
    };

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    orderItems: (json['orderItems'] as List<dynamic>)
        .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
    };

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
