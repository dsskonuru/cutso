// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    applicableItemIds: (json['applicableItemIds'] as List<dynamic>)
        .map((e) => e as int)
        .toList(),
    uid: json['uid'] as String,
    value: (json['value'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'applicableItemIds': instance.applicableItemIds,
      'uid': instance.uid,
      'value': instance.value,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    name: json['name'] as String?,
    location: Address._fromJsonGeoPoint(json['location'] as GeoPoint?),
    line1: json['line1'] as String?,
    line2: json['line2'] as String?,
    landmark: json['landmark'] as String?,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'location': Address._toJsonGeoPoint(instance.location),
      'line1': instance.line1,
      'line2': instance.line2,
      'landmark': instance.landmark,
    };
