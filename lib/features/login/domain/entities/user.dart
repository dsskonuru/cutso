import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class User extends Equatable {
  final String uid;
  final String full_name;
  final int phone;
  final String email;
  final Address address;
  final Cart cart;

  User({
    required this.uid,
    required this.full_name,
    required this.phone,
    required this.email,
    required this.address,
    required this.cart,
  });

  @override
  List<Object?> get props => [
        uid,
        full_name,
        phone,
        email,
        address,
        cart,
      ];
}

@JsonSerializable(explicitToJson: true)
class Address extends Equatable {
  final String name;
  final String line;
  final String landmark;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint location;

  Address({
    required this.name,
    required this.location,
    required this.line,
    required this.landmark,
  });

  @override
  List<Object?> get props => [name, location, line, landmark];

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }
}

@JsonSerializable(explicitToJson: true)
class Cart extends Equatable {
  final List<OrderItem> orderItems;

  Cart({
    required this.orderItems,
  });

  Cart.empty() : orderItems = [];

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  void add(OrderItem orderItem) {
    orderItems.add(orderItem);
  }

  void remove(OrderItem orderItem) {
    orderItems.remove(orderItem);
  }

  @override
  List<Object?> get props => [orderItems];
}

@JsonSerializable(explicitToJson: true)
class OrderItem extends Equatable {
  final int itemId;
  final double quantity;
  final Set<String> tags; // includes sizes and preferences
  final String? guidelines;
  final double price;

  OrderItem({
    required this.itemId,
    required this.quantity,
    required this.tags, // includes sizes and preferences
    required this.guidelines,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  List<Object?> get props => [itemId, quantity, tags, guidelines, price];
}
