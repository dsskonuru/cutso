// ignore_for_file: invalid_annotation_target

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
    required List<CartItem> cart,
    required List<String> orders,
  }) = _User;

  const User._();

  void addOrder(String id) {
    orders.add(id);
  }

  void removeOrder(String id) {
    orders.remove(id);
  }

  void addToCart(CartItem cartItem) {
    cart.add(cartItem);
  }

  void removeFromCart(CartItem cartItem) {
    cart.remove(cartItem);
  }

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
class CartItem with _$CartItem {
  @JsonSerializable(explicitToJson: true)
  factory CartItem({
    required int itemId,
    required double quantity,
    required String? sizeTag,
    required Set<String>? preferenceTags,
    required String? guidelines,
    required double price,
  }) = _CartItem;
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
