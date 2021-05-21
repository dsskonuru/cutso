import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String code;
  final List<int> applicableItemIds;
  final double minCartValue;
  final String name;
  final String? description;
  final bool isActive;

  Coupon({
    required this.code,
    required this.applicableItemIds,
    required this.minCartValue,
    required this.name,
    required this.description,
    required this.isActive,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        code,
        applicableItemIds,
        minCartValue,
        name,
        description,
        isActive,
      ];
}
