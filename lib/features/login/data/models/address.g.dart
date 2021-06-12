// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    name: json['name'] as String,
    location: Address._fromJsonGeoPoint(json['location'] as GeoPoint),
    line: json['line'] as String,
    landmark: json['landmark'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'line': instance.line,
      'landmark': instance.landmark,
      'location': Address._toJsonGeoPoint(instance.location),
    };
