// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    json['fullName'] as String,
    json['phoneNumber'] as int,
    json['email'] as String,
    (json['address'] as List<dynamic>)
        .map((e) => Address.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
    };

_$_Address _$_$_AddressFromJson(Map<String, dynamic> json) {
  return _$_Address(
    json['name'] as String,
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
    json['line1'] as String,
    json['line2'] as String,
    json['landmark'] as String,
  );
}

Map<String, dynamic> _$_$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'line1': instance.line1,
      'line2': instance.line2,
      'landmark': instance.landmark,
    };

_$_ProductsList _$_$_ProductsListFromJson(Map<String, dynamic> json) {
  return _$_ProductsList(
    (json['productsList'] as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_ProductsListToJson(_$_ProductsList instance) =>
    <String, dynamic>{
      'productsList': instance.productsList,
    };

_$_Product _$_$_ProductFromJson(Map<String, dynamic> json) {
  return _$_Product(
    name: json['name'] as String?,
    available: json['available'] as bool?,
    description: json['description'] as String?,
    sizes: json['sizes'] as bool?,
  );
}

Map<String, dynamic> _$_$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'name': instance.name,
      'available': instance.available,
      'description': instance.description,
      'sizes': instance.sizes,
    };
