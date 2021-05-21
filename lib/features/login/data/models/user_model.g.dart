// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json['uid'] as String?,
    full_name: json['full_name'] as String?,
    phone: json['phone'] as int?,
    email: json['email'] as String?,
    addresses: (json['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
        .toList(),
    cart: json['cart'] == null
        ? null
        : Cart.fromJson(json['cart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'full_name': instance.full_name,
      'phone': instance.phone,
      'email': instance.email,
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
      'cart': instance.cart?.toJson(),
    };
