import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem extends Equatable {
  final int itemId;
  final double quantity;
  final Set<String> tags; // includes sizes and preferences
  final String? guidelines;
  final double price;

  const OrderItem({
    required this.itemId,
    required this.quantity,
    required this.tags, // includes sizes and preferences
    required this.guidelines,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  List<Object?> get props => [itemId, quantity, tags, guidelines, price];
}
