import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String uid,
    required String fullName,
    required String phone,
    required String email,
    required Address address,
    required Cart cart,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Address with _$Address {
  @JsonSerializable(explicitToJson: true)
  factory Address({
    required String name,
    required String line,
    required String landmark,
    @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
        required GeoPoint location,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
  return geoPoint;
}

GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
  return geoPoint;
}

@freezed
class OrderItem with _$OrderItem {
  @JsonSerializable(explicitToJson: true)
  factory OrderItem({
    required int itemId,
    required double quantity,
    required Set<String>? sizeTags,
    required Set<String>? preferenceTags,
    required String? guidelines,
    required double price,
  }) = _OrderItem;
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}

@freezed
class Cart with _$Cart {
  @JsonSerializable(explicitToJson: true)
  factory Cart({
    required List<OrderItem> orderItems,
  }) = _Cart;
  const Cart._();

  // Cart.empty() = Cart(orderItems: []);

  void add(OrderItem orderItem) {
    orderItems.add(orderItem);
  }

  void remove(OrderItem orderItem) {
    orderItems.remove(orderItem);
  }

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}