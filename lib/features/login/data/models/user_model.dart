import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {
  UserModel({
    required String uid,
    required String full_name,
    required int phone,
    required String email,
    required Address address,
    required Cart cart,
  }) : super(
          uid: uid,
          full_name: full_name,
          phone: phone,
          email: email,
          address: address,
          cart: cart,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  void updateCart(Cart cart) {}
}
