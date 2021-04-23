import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'freezed_classes.freezed.dart';
part 'freezed_classes.g.dart';

@freezed
class User with _$User {
  const factory User(String fullName, int phoneNumber, String email,
      List<Address> address) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address(String name, double latitude, double longitude,
      String line1, String line2, String landmark) = _Address;
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class ProductsList with _$ProductsList {
  const factory ProductsList(List<Product> productsList) = _ProductsList;
  factory ProductsList.fromJson(Map<String, dynamic> json) =>
      _$ProductsListFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product(
      {String? name, bool? available, String? description, bool? sizes}) = _Product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

