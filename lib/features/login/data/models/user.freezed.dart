// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String uid,
      required String fullName,
      required String phone,
      required String email,
      required Address address,
      required Cart cart,
      required MyOrders orders}) {
    return _User(
      uid: uid,
      fullName: fullName,
      phone: phone,
      email: email,
      address: address,
      cart: cart,
      orders: orders,
    );
  }

  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get uid => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  Cart get cart => throw _privateConstructorUsedError;
  MyOrders get orders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String fullName,
      String phone,
      String email,
      Address address,
      Cart cart,
      MyOrders orders});

  $AddressCopyWith<$Res> get address;
  $CartCopyWith<$Res> get cart;
  $MyOrdersCopyWith<$Res> get orders;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? cart = freezed,
    Object? orders = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      orders: orders == freezed
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as MyOrders,
    ));
  }

  @override
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value));
    });
  }

  @override
  $CartCopyWith<$Res> get cart {
    return $CartCopyWith<$Res>(_value.cart, (value) {
      return _then(_value.copyWith(cart: value));
    });
  }

  @override
  $MyOrdersCopyWith<$Res> get orders {
    return $MyOrdersCopyWith<$Res>(_value.orders, (value) {
      return _then(_value.copyWith(orders: value));
    });
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String fullName,
      String phone,
      String email,
      Address address,
      Cart cart,
      MyOrders orders});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $CartCopyWith<$Res> get cart;
  @override
  $MyOrdersCopyWith<$Res> get orders;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? uid = freezed,
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? cart = freezed,
    Object? orders = freezed,
  }) {
    return _then(_User(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      orders: orders == freezed
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as MyOrders,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_User with DiagnosticableTreeMixin implements _User {
  _$_User(
      {required this.uid,
      required this.fullName,
      required this.phone,
      required this.email,
      required this.address,
      required this.cart,
      required this.orders});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String uid;
  @override
  final String fullName;
  @override
  final String phone;
  @override
  final String email;
  @override
  final Address address;
  @override
  final Cart cart;
  @override
  final MyOrders orders;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(uid: $uid, fullName: $fullName, phone: $phone, email: $email, address: $address, cart: $cart, orders: $orders)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('cart', cart))
      ..add(DiagnosticsProperty('orders', orders));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.cart, cart) ||
                const DeepCollectionEquality().equals(other.cart, cart)) &&
            (identical(other.orders, orders) ||
                const DeepCollectionEquality().equals(other.orders, orders)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(cart) ^
      const DeepCollectionEquality().hash(orders);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  factory _User(
      {required String uid,
      required String fullName,
      required String phone,
      required String email,
      required Address address,
      required Cart cart,
      required MyOrders orders}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get phone => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  Address get address => throw _privateConstructorUsedError;
  @override
  Cart get cart => throw _privateConstructorUsedError;
  @override
  MyOrders get orders => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
class _$AddressTearOff {
  const _$AddressTearOff();

  _Address call(
      {required String name,
      required String line,
      required String landmark,
      @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
          required GeoPoint location}) {
    return _Address(
      name: name,
      line: line,
      landmark: landmark,
      location: location,
    );
  }

  Address fromJson(Map<String, Object> json) {
    return Address.fromJson(json);
  }
}

/// @nodoc
const $Address = _$AddressTearOff();

/// @nodoc
mixin _$Address {
  String get name => throw _privateConstructorUsedError;
  String get line => throw _privateConstructorUsedError;
  String get landmark => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  GeoPoint get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String line,
      String landmark,
      @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
          GeoPoint location});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  final Address _value;
  // ignore: unused_field
  final $Res Function(Address) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? line = freezed,
    Object? landmark = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      line: line == freezed
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: landmark == freezed
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
    ));
  }
}

/// @nodoc
abstract class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) then) =
      __$AddressCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String line,
      String landmark,
      @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
          GeoPoint location});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> extends _$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(_Address _value, $Res Function(_Address) _then)
      : super(_value, (v) => _then(v as _Address));

  @override
  _Address get _value => super._value as _Address;

  @override
  $Res call({
    Object? name = freezed,
    Object? line = freezed,
    Object? landmark = freezed,
    Object? location = freezed,
  }) {
    return _then(_Address(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      line: line == freezed
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: landmark == freezed
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Address with DiagnosticableTreeMixin implements _Address {
  _$_Address(
      {required this.name,
      required this.line,
      required this.landmark,
      @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
          required this.location});

  factory _$_Address.fromJson(Map<String, dynamic> json) =>
      _$_$_AddressFromJson(json);

  @override
  final String name;
  @override
  final String line;
  @override
  final String landmark;
  @override
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint location;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Address(name: $name, line: $line, landmark: $landmark, location: $location)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Address'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('landmark', landmark))
      ..add(DiagnosticsProperty('location', location));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Address &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.line, line) ||
                const DeepCollectionEquality().equals(other.line, line)) &&
            (identical(other.landmark, landmark) ||
                const DeepCollectionEquality()
                    .equals(other.landmark, landmark)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(line) ^
      const DeepCollectionEquality().hash(landmark) ^
      const DeepCollectionEquality().hash(location);

  @JsonKey(ignore: true)
  @override
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AddressToJson(this);
  }
}

abstract class _Address implements Address {
  factory _Address(
      {required String name,
      required String line,
      required String landmark,
      @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
          required GeoPoint location}) = _$_Address;

  factory _Address.fromJson(Map<String, dynamic> json) = _$_Address.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get line => throw _privateConstructorUsedError;
  @override
  String get landmark => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  GeoPoint get location => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddressCopyWith<_Address> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
class _$OrderItemTearOff {
  const _$OrderItemTearOff();

  _OrderItem call(
      {required int itemId,
      required double quantity,
      required Set<String>? sizeTags,
      required Set<String>? preferenceTags,
      required String? guidelines,
      required double price}) {
    return _OrderItem(
      itemId: itemId,
      quantity: quantity,
      sizeTags: sizeTags,
      preferenceTags: preferenceTags,
      guidelines: guidelines,
      price: price,
    );
  }

  OrderItem fromJson(Map<String, Object> json) {
    return OrderItem.fromJson(json);
  }
}

/// @nodoc
const $OrderItem = _$OrderItemTearOff();

/// @nodoc
mixin _$OrderItem {
  int get itemId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  Set<String>? get sizeTags => throw _privateConstructorUsedError;
  Set<String>? get preferenceTags => throw _privateConstructorUsedError;
  String? get guidelines => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res>;
  $Res call(
      {int itemId,
      double quantity,
      Set<String>? sizeTags,
      Set<String>? preferenceTags,
      String? guidelines,
      double price});
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res> implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  final OrderItem _value;
  // ignore: unused_field
  final $Res Function(OrderItem) _then;

  @override
  $Res call({
    Object? itemId = freezed,
    Object? quantity = freezed,
    Object? sizeTags = freezed,
    Object? preferenceTags = freezed,
    Object? guidelines = freezed,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      sizeTags: sizeTags == freezed
          ? _value.sizeTags
          : sizeTags // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      preferenceTags: preferenceTags == freezed
          ? _value.preferenceTags
          : preferenceTags // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      guidelines: guidelines == freezed
          ? _value.guidelines
          : guidelines // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(
          _OrderItem value, $Res Function(_OrderItem) then) =
      __$OrderItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {int itemId,
      double quantity,
      Set<String>? sizeTags,
      Set<String>? preferenceTags,
      String? guidelines,
      double price});
}

/// @nodoc
class __$OrderItemCopyWithImpl<$Res> extends _$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(_OrderItem _value, $Res Function(_OrderItem) _then)
      : super(_value, (v) => _then(v as _OrderItem));

  @override
  _OrderItem get _value => super._value as _OrderItem;

  @override
  $Res call({
    Object? itemId = freezed,
    Object? quantity = freezed,
    Object? sizeTags = freezed,
    Object? preferenceTags = freezed,
    Object? guidelines = freezed,
    Object? price = freezed,
  }) {
    return _then(_OrderItem(
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      sizeTags: sizeTags == freezed
          ? _value.sizeTags
          : sizeTags // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      preferenceTags: preferenceTags == freezed
          ? _value.preferenceTags
          : preferenceTags // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      guidelines: guidelines == freezed
          ? _value.guidelines
          : guidelines // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OrderItem with DiagnosticableTreeMixin implements _OrderItem {
  _$_OrderItem(
      {required this.itemId,
      required this.quantity,
      required this.sizeTags,
      required this.preferenceTags,
      required this.guidelines,
      required this.price});

  factory _$_OrderItem.fromJson(Map<String, dynamic> json) =>
      _$_$_OrderItemFromJson(json);

  @override
  final int itemId;
  @override
  final double quantity;
  @override
  final Set<String>? sizeTags;
  @override
  final Set<String>? preferenceTags;
  @override
  final String? guidelines;
  @override
  final double price;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderItem(itemId: $itemId, quantity: $quantity, sizeTags: $sizeTags, preferenceTags: $preferenceTags, guidelines: $guidelines, price: $price)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderItem'))
      ..add(DiagnosticsProperty('itemId', itemId))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('sizeTags', sizeTags))
      ..add(DiagnosticsProperty('preferenceTags', preferenceTags))
      ..add(DiagnosticsProperty('guidelines', guidelines))
      ..add(DiagnosticsProperty('price', price));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OrderItem &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.sizeTags, sizeTags) ||
                const DeepCollectionEquality()
                    .equals(other.sizeTags, sizeTags)) &&
            (identical(other.preferenceTags, preferenceTags) ||
                const DeepCollectionEquality()
                    .equals(other.preferenceTags, preferenceTags)) &&
            (identical(other.guidelines, guidelines) ||
                const DeepCollectionEquality()
                    .equals(other.guidelines, guidelines)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(itemId) ^
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(sizeTags) ^
      const DeepCollectionEquality().hash(preferenceTags) ^
      const DeepCollectionEquality().hash(guidelines) ^
      const DeepCollectionEquality().hash(price);

  @JsonKey(ignore: true)
  @override
  _$OrderItemCopyWith<_OrderItem> get copyWith =>
      __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OrderItemToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  factory _OrderItem(
      {required int itemId,
      required double quantity,
      required Set<String>? sizeTags,
      required Set<String>? preferenceTags,
      required String? guidelines,
      required double price}) = _$_OrderItem;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$_OrderItem.fromJson;

  @override
  int get itemId => throw _privateConstructorUsedError;
  @override
  double get quantity => throw _privateConstructorUsedError;
  @override
  Set<String>? get sizeTags => throw _privateConstructorUsedError;
  @override
  Set<String>? get preferenceTags => throw _privateConstructorUsedError;
  @override
  String? get guidelines => throw _privateConstructorUsedError;
  @override
  double get price => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OrderItemCopyWith<_OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Cart.fromJson(json);
}

/// @nodoc
class _$CartTearOff {
  const _$CartTearOff();

  _Cart call({required List<OrderItem> orderItems}) {
    return _Cart(
      orderItems: orderItems,
    );
  }

  Cart fromJson(Map<String, Object> json) {
    return Cart.fromJson(json);
  }
}

/// @nodoc
const $Cart = _$CartTearOff();

/// @nodoc
mixin _$Cart {
  List<OrderItem> get orderItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res>;
  $Res call({List<OrderItem> orderItems});
}

/// @nodoc
class _$CartCopyWithImpl<$Res> implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  final Cart _value;
  // ignore: unused_field
  final $Res Function(Cart) _then;

  @override
  $Res call({
    Object? orderItems = freezed,
  }) {
    return _then(_value.copyWith(
      orderItems: orderItems == freezed
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
    ));
  }
}

/// @nodoc
abstract class _$CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$CartCopyWith(_Cart value, $Res Function(_Cart) then) =
      __$CartCopyWithImpl<$Res>;
  @override
  $Res call({List<OrderItem> orderItems});
}

/// @nodoc
class __$CartCopyWithImpl<$Res> extends _$CartCopyWithImpl<$Res>
    implements _$CartCopyWith<$Res> {
  __$CartCopyWithImpl(_Cart _value, $Res Function(_Cart) _then)
      : super(_value, (v) => _then(v as _Cart));

  @override
  _Cart get _value => super._value as _Cart;

  @override
  $Res call({
    Object? orderItems = freezed,
  }) {
    return _then(_Cart(
      orderItems: orderItems == freezed
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Cart extends _Cart with DiagnosticableTreeMixin {
  _$_Cart({required this.orderItems}) : super._();

  factory _$_Cart.fromJson(Map<String, dynamic> json) =>
      _$_$_CartFromJson(json);

  @override
  final List<OrderItem> orderItems;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Cart(orderItems: $orderItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Cart'))
      ..add(DiagnosticsProperty('orderItems', orderItems));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Cart &&
            (identical(other.orderItems, orderItems) ||
                const DeepCollectionEquality()
                    .equals(other.orderItems, orderItems)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(orderItems);

  @JsonKey(ignore: true)
  @override
  _$CartCopyWith<_Cart> get copyWith =>
      __$CartCopyWithImpl<_Cart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CartToJson(this);
  }
}

abstract class _Cart extends Cart {
  factory _Cart({required List<OrderItem> orderItems}) = _$_Cart;
  _Cart._() : super._();

  factory _Cart.fromJson(Map<String, dynamic> json) = _$_Cart.fromJson;

  @override
  List<OrderItem> get orderItems => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CartCopyWith<_Cart> get copyWith => throw _privateConstructorUsedError;
}

MyOrders _$MyOrdersFromJson(Map<String, dynamic> json) {
  return _MyOrders.fromJson(json);
}

/// @nodoc
class _$MyOrdersTearOff {
  const _$MyOrdersTearOff();

  _MyOrders call({required List<String> orderIds}) {
    return _MyOrders(
      orderIds: orderIds,
    );
  }

  MyOrders fromJson(Map<String, Object> json) {
    return MyOrders.fromJson(json);
  }
}

/// @nodoc
const $MyOrders = _$MyOrdersTearOff();

/// @nodoc
mixin _$MyOrders {
  List<String> get orderIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyOrdersCopyWith<MyOrders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyOrdersCopyWith<$Res> {
  factory $MyOrdersCopyWith(MyOrders value, $Res Function(MyOrders) then) =
      _$MyOrdersCopyWithImpl<$Res>;
  $Res call({List<String> orderIds});
}

/// @nodoc
class _$MyOrdersCopyWithImpl<$Res> implements $MyOrdersCopyWith<$Res> {
  _$MyOrdersCopyWithImpl(this._value, this._then);

  final MyOrders _value;
  // ignore: unused_field
  final $Res Function(MyOrders) _then;

  @override
  $Res call({
    Object? orderIds = freezed,
  }) {
    return _then(_value.copyWith(
      orderIds: orderIds == freezed
          ? _value.orderIds
          : orderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$MyOrdersCopyWith<$Res> implements $MyOrdersCopyWith<$Res> {
  factory _$MyOrdersCopyWith(_MyOrders value, $Res Function(_MyOrders) then) =
      __$MyOrdersCopyWithImpl<$Res>;
  @override
  $Res call({List<String> orderIds});
}

/// @nodoc
class __$MyOrdersCopyWithImpl<$Res> extends _$MyOrdersCopyWithImpl<$Res>
    implements _$MyOrdersCopyWith<$Res> {
  __$MyOrdersCopyWithImpl(_MyOrders _value, $Res Function(_MyOrders) _then)
      : super(_value, (v) => _then(v as _MyOrders));

  @override
  _MyOrders get _value => super._value as _MyOrders;

  @override
  $Res call({
    Object? orderIds = freezed,
  }) {
    return _then(_MyOrders(
      orderIds: orderIds == freezed
          ? _value.orderIds
          : orderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MyOrders extends _MyOrders with DiagnosticableTreeMixin {
  _$_MyOrders({required this.orderIds}) : super._();

  factory _$_MyOrders.fromJson(Map<String, dynamic> json) =>
      _$_$_MyOrdersFromJson(json);

  @override
  final List<String> orderIds;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyOrders(orderIds: $orderIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyOrders'))
      ..add(DiagnosticsProperty('orderIds', orderIds));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyOrders &&
            (identical(other.orderIds, orderIds) ||
                const DeepCollectionEquality()
                    .equals(other.orderIds, orderIds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(orderIds);

  @JsonKey(ignore: true)
  @override
  _$MyOrdersCopyWith<_MyOrders> get copyWith =>
      __$MyOrdersCopyWithImpl<_MyOrders>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyOrdersToJson(this);
  }
}

abstract class _MyOrders extends MyOrders {
  factory _MyOrders({required List<String> orderIds}) = _$_MyOrders;
  _MyOrders._() : super._();

  factory _MyOrders.fromJson(Map<String, dynamic> json) = _$_MyOrders.fromJson;

  @override
  List<String> get orderIds => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MyOrdersCopyWith<_MyOrders> get copyWith =>
      throw _privateConstructorUsedError;
}
