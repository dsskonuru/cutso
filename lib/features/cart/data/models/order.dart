// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../login/data/models/user.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum Status {
  paymentPending,
  paymentFailed,
  sent,
  approved,
  processing,
  outForDelivery,
  delivered,
}

@freezed
class Order with _$Order {
  @JsonSerializable(explicitToJson: true)
  factory Order({
    required String uid,
    required String id,
    required List<CartItem> items,
    required double value,
    required Coupon? coupon,
    required Status? status,
  }) = _Order;
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class Coupon with _$Coupon {
  @JsonSerializable(explicitToJson: true)
  factory Coupon({
    required String code,
    required List<int> applicableItemIds,
    required double minCartValue,
    required String name,
    required String? description,
    required bool isActive,
  }) = _Coupon;
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}
