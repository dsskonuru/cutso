// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    uid: json['uid'] as String,
    fullName: json['fullName'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
    cart: Cart.fromJson(json['cart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address.toJson(),
      'cart': instance.cart.toJson(),
    };

_$_Address _$_$_AddressFromJson(Map<String, dynamic> json) {
  return _$_Address(
    name: json['name'] as String,
    line: json['line'] as String,
    landmark: json['landmark'] as String,
    location: _fromJsonGeoPoint(json['location'] as GeoPoint),
  );
}

Map<String, dynamic> _$_$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'name': instance.name,
      'line': instance.line,
      'landmark': instance.landmark,
      'location': _toJsonGeoPoint(instance.location),
    };

_$_OrderItem _$_$_OrderItemFromJson(Map<String, dynamic> json) {
  return _$_OrderItem(
    itemId: json['itemId'] as int,
    quantity: (json['quantity'] as num).toDouble(),
    sizeTags:
        (json['sizeTags'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    preferenceTags: (json['preferenceTags'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toSet(),
    guidelines: json['guidelines'] as String?,
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$_$_OrderItemToJson(_$_OrderItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'sizeTags': instance.sizeTags?.toList(),
      'preferenceTags': instance.preferenceTags?.toList(),
      'guidelines': instance.guidelines,
      'price': instance.price,
    };

_$_Cart _$_$_CartFromJson(Map<String, dynamic> json) {
  return _$_Cart(
    orderItems: (json['orderItems'] as List<dynamic>)
        .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_CartToJson(_$_Cart instance) => <String, dynamic>{
      'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
    };
