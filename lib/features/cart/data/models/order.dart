import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../login/data/models/cart.dart';

part 'order.g.dart';

enum Status {
  paymentPending,
  sent,
  approved,
  processing,
  outForDelivery,
  delivered,
}

@JsonSerializable(explicitToJson: true)
class Order extends Equatable {
  final String uid;
  final String orderId;
  final Cart orderItems;
  final double value;
  final Coupon? coupon;
  final Status? status;

  const Order({
    required this.uid,
    required this.orderId,
    required this.orderItems,
    required this.value,
    this.coupon,
    this.status,
  });

  @override
  List<Object?> get props => [
        uid,
        orderId,
        orderItems,
        value,
        coupon,
        status,
      ];

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Coupon extends Equatable {
  final String code;
  final List<int> applicableItemIds;
  final double minCartValue;
  final String name;
  final String? description;
  final bool isActive;

  const Coupon({
    required this.code,
    required this.applicableItemIds,
    required this.minCartValue,
    required this.name,
    required this.description,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        code,
        applicableItemIds,
        minCartValue,
        name,
        description,
        isActive,
      ];

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
