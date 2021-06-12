import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'cart.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  final String uid;
  final String fullName;
  final String phone;
  final String email;
  final Address address;
  final Cart cart;

  const User({
    required this.uid,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.cart,
  });

  @override
  List<Object?> get props => [
        uid,
        fullName,
        phone,
        email,
        address,
        cart,
      ];

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}