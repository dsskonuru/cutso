// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] as String,
    full_name: json['full_name'] as String,
    phone: json['phone'] as int,
    email: json['email'] as String,
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
    cart: Cart.fromJson(json['cart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'full_name': instance.full_name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address.toJson(),
      'cart': instance.cart.toJson(),
    };
