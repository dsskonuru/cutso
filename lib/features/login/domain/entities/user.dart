import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class User extends Equatable {
  final String? uid;
  final String? full_name;
  final int? phone;
  final String? email;
  final List<Address>? addresses;
  final Cart? cart;

  User(
      {required this.uid,
      required this.full_name,
      required this.phone,
      required this.email,
      required this.addresses,
      required this.cart});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        uid,
        full_name,
        phone,
        email,
        addresses,
      ];
}

@JsonSerializable(explicitToJson: true)
class Cart extends Equatable {
  final List<int> applicableItemIds;
  final String uid;
  final double value;

  Cart({
    required this.applicableItemIds,
    required this.uid,
    required this.value,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [applicableItemIds, uid, value];

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address extends Equatable {
  final String? name;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint? location;
  final String? line1;
  final String? line2;
  final String? landmark;

  Address({
    required this.name,
    required this.location,
    required this.line1,
    required this.line2,
    required this.landmark,
  });

  static GeoPoint? _fromJsonGeoPoint(GeoPoint? geoPoint) {
    return geoPoint;
  }

  static GeoPoint? _toJsonGeoPoint(GeoPoint? geoPoint) {
    return geoPoint;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [name, location, line1, line2, landmark];

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
