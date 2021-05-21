// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) {
  return CouponModel(
    code: json['code'] as String,
    applicableItemIds: (json['applicableItemIds'] as List<dynamic>)
        .map((e) => e as int)
        .toList(),
    minCartValue: (json['minCartValue'] as num).toDouble(),
    name: json['name'] as String,
    description: json['description'] as String?,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'applicableItemIds': instance.applicableItemIds,
      'minCartValue': instance.minCartValue,
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
    };
