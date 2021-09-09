// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
class _$OrderTearOff {
  const _$OrderTearOff();

  _Order call(
      {required String uid,
      required String id,
      required List<CartItem> items,
      required double value,
      required Coupon? coupon,
      required Status? status}) {
    return _Order(
      uid: uid,
      id: id,
      items: items,
      value: value,
      coupon: coupon,
      status: status,
    );
  }

  Order fromJson(Map<String, Object> json) {
    return Order.fromJson(json);
  }
}

/// @nodoc
const $Order = _$OrderTearOff();

/// @nodoc
mixin _$Order {
  String get uid => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<CartItem> get items => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  Coupon? get coupon => throw _privateConstructorUsedError;
  Status? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String id,
      List<CartItem> items,
      double value,
      Coupon? coupon,
      Status? status});

  $CouponCopyWith<$Res>? get coupon;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  final Order _value;
  // ignore: unused_field
  final $Res Function(Order) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? items = freezed,
    Object? value = freezed,
    Object? coupon = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      coupon: coupon == freezed
          ? _value.coupon
          : coupon // ignore: cast_nullable_to_non_nullable
              as Coupon?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ));
  }

  @override
  $CouponCopyWith<$Res>? get coupon {
    if (_value.coupon == null) {
      return null;
    }

    return $CouponCopyWith<$Res>(_value.coupon!, (value) {
      return _then(_value.copyWith(coupon: value));
    });
  }
}

/// @nodoc
abstract class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) then) =
      __$OrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String id,
      List<CartItem> items,
      double value,
      Coupon? coupon,
      Status? status});

  @override
  $CouponCopyWith<$Res>? get coupon;
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(_Order _value, $Res Function(_Order) _then)
      : super(_value, (v) => _then(v as _Order));

  @override
  _Order get _value => super._value as _Order;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? items = freezed,
    Object? value = freezed,
    Object? coupon = freezed,
    Object? status = freezed,
  }) {
    return _then(_Order(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      coupon: coupon == freezed
          ? _value.coupon
          : coupon // ignore: cast_nullable_to_non_nullable
              as Coupon?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Order implements _Order {
  _$_Order(
      {required this.uid,
      required this.id,
      required this.items,
      required this.value,
      required this.coupon,
      required this.status});

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$_$_OrderFromJson(json);

  @override
  final String uid;
  @override
  final String id;
  @override
  final List<CartItem> items;
  @override
  final double value;
  @override
  final Coupon? coupon;
  @override
  final Status? status;

  @override
  String toString() {
    return 'Order(uid: $uid, id: $id, items: $items, value: $value, coupon: $coupon, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Order &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.coupon, coupon) ||
                const DeepCollectionEquality().equals(other.coupon, coupon)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(coupon) ^
      const DeepCollectionEquality().hash(status);

  @JsonKey(ignore: true)
  @override
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OrderToJson(this);
  }
}

abstract class _Order implements Order {
  factory _Order(
      {required String uid,
      required String id,
      required List<CartItem> items,
      required double value,
      required Coupon? coupon,
      required Status? status}) = _$_Order;

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  List<CartItem> get items => throw _privateConstructorUsedError;
  @override
  double get value => throw _privateConstructorUsedError;
  @override
  Coupon? get coupon => throw _privateConstructorUsedError;
  @override
  Status? get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OrderCopyWith<_Order> get copyWith => throw _privateConstructorUsedError;
}

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return _Coupon.fromJson(json);
}

/// @nodoc
class _$CouponTearOff {
  const _$CouponTearOff();

  _Coupon call(
      {required String code,
      required List<int> applicableItemIds,
      required double minCartValue,
      required String name,
      required String? description,
      required bool isActive}) {
    return _Coupon(
      code: code,
      applicableItemIds: applicableItemIds,
      minCartValue: minCartValue,
      name: name,
      description: description,
      isActive: isActive,
    );
  }

  Coupon fromJson(Map<String, Object> json) {
    return Coupon.fromJson(json);
  }
}

/// @nodoc
const $Coupon = _$CouponTearOff();

/// @nodoc
mixin _$Coupon {
  String get code => throw _privateConstructorUsedError;
  List<int> get applicableItemIds => throw _privateConstructorUsedError;
  double get minCartValue => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CouponCopyWith<Coupon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouponCopyWith<$Res> {
  factory $CouponCopyWith(Coupon value, $Res Function(Coupon) then) =
      _$CouponCopyWithImpl<$Res>;
  $Res call(
      {String code,
      List<int> applicableItemIds,
      double minCartValue,
      String name,
      String? description,
      bool isActive});
}

/// @nodoc
class _$CouponCopyWithImpl<$Res> implements $CouponCopyWith<$Res> {
  _$CouponCopyWithImpl(this._value, this._then);

  final Coupon _value;
  // ignore: unused_field
  final $Res Function(Coupon) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? applicableItemIds = freezed,
    Object? minCartValue = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      applicableItemIds: applicableItemIds == freezed
          ? _value.applicableItemIds
          : applicableItemIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      minCartValue: minCartValue == freezed
          ? _value.minCartValue
          : minCartValue // ignore: cast_nullable_to_non_nullable
              as double,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$CouponCopyWith<$Res> implements $CouponCopyWith<$Res> {
  factory _$CouponCopyWith(_Coupon value, $Res Function(_Coupon) then) =
      __$CouponCopyWithImpl<$Res>;
  @override
  $Res call(
      {String code,
      List<int> applicableItemIds,
      double minCartValue,
      String name,
      String? description,
      bool isActive});
}

/// @nodoc
class __$CouponCopyWithImpl<$Res> extends _$CouponCopyWithImpl<$Res>
    implements _$CouponCopyWith<$Res> {
  __$CouponCopyWithImpl(_Coupon _value, $Res Function(_Coupon) _then)
      : super(_value, (v) => _then(v as _Coupon));

  @override
  _Coupon get _value => super._value as _Coupon;

  @override
  $Res call({
    Object? code = freezed,
    Object? applicableItemIds = freezed,
    Object? minCartValue = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_Coupon(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      applicableItemIds: applicableItemIds == freezed
          ? _value.applicableItemIds
          : applicableItemIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      minCartValue: minCartValue == freezed
          ? _value.minCartValue
          : minCartValue // ignore: cast_nullable_to_non_nullable
              as double,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Coupon implements _Coupon {
  _$_Coupon(
      {required this.code,
      required this.applicableItemIds,
      required this.minCartValue,
      required this.name,
      required this.description,
      required this.isActive});

  factory _$_Coupon.fromJson(Map<String, dynamic> json) =>
      _$_$_CouponFromJson(json);

  @override
  final String code;
  @override
  final List<int> applicableItemIds;
  @override
  final double minCartValue;
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'Coupon(code: $code, applicableItemIds: $applicableItemIds, minCartValue: $minCartValue, name: $name, description: $description, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Coupon &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.applicableItemIds, applicableItemIds) ||
                const DeepCollectionEquality()
                    .equals(other.applicableItemIds, applicableItemIds)) &&
            (identical(other.minCartValue, minCartValue) ||
                const DeepCollectionEquality()
                    .equals(other.minCartValue, minCartValue)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(applicableItemIds) ^
      const DeepCollectionEquality().hash(minCartValue) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive);

  @JsonKey(ignore: true)
  @override
  _$CouponCopyWith<_Coupon> get copyWith =>
      __$CouponCopyWithImpl<_Coupon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CouponToJson(this);
  }
}

abstract class _Coupon implements Coupon {
  factory _Coupon(
      {required String code,
      required List<int> applicableItemIds,
      required double minCartValue,
      required String name,
      required String? description,
      required bool isActive}) = _$_Coupon;

  factory _Coupon.fromJson(Map<String, dynamic> json) = _$_Coupon.fromJson;

  @override
  String get code => throw _privateConstructorUsedError;
  @override
  List<int> get applicableItemIds => throw _privateConstructorUsedError;
  @override
  double get minCartValue => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CouponCopyWith<_Coupon> get copyWith => throw _privateConstructorUsedError;
}
