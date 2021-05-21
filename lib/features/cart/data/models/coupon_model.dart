import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/coupon.dart';

part 'coupon_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CouponModel extends Coupon {
  CouponModel({
    required String code,
    required List<int> applicableItemIds,
    required double minCartValue,
    required String name,
    required String? description,
    required bool isActive,
  }) : super(
          code: code,
          applicableItemIds: applicableItemIds,
          minCartValue: minCartValue,
          name: name,
          description: description,
          isActive: isActive,
        );

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
