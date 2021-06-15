// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$_$_OrderFromJson(Map<String, dynamic> json) {
  return _$_Order(
    uid: json['uid'] as String,
    orderId: json['orderId'] as String,
    orderItems: Cart.fromJson(json['orderItems'] as Map<String, dynamic>),
    value: (json['value'] as num).toDouble(),
    coupon: json['coupon'] == null
        ? null
        : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
    status: _$enumDecodeNullable(_$StatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$_$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'uid': instance.uid,
      'orderId': instance.orderId,
      'orderItems': instance.orderItems.toJson(),
      'value': instance.value,
      'coupon': instance.coupon?.toJson(),
      'status': _$StatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$StatusEnumMap = {
  Status.paymentPending: 'paymentPending',
  Status.sent: 'sent',
  Status.approved: 'approved',
  Status.processing: 'processing',
  Status.outForDelivery: 'outForDelivery',
  Status.delivered: 'delivered',
};

_$_Coupon _$_$_CouponFromJson(Map<String, dynamic> json) {
  return _$_Coupon(
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

Map<String, dynamic> _$_$_CouponToJson(_$_Coupon instance) => <String, dynamic>{
      'code': instance.code,
      'applicableItemIds': instance.applicableItemIds,
      'minCartValue': instance.minCartValue,
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
    };
