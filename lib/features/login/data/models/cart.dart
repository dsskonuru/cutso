import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends Equatable {
  final List<OrderItem> orderItems;

  const Cart({
    required this.orderItems,
  });

  Cart.empty() : orderItems = [];

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  void add(OrderItem orderItem) {
    orderItems.add(orderItem);
  }

  void remove(OrderItem orderItem) {
    orderItems.remove(orderItem);
  }

  @override
  List<Object?> get props => [orderItems];
}
