import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemModel extends Item {
  ItemModel(
      {required int id,
      required String name,
      required String category,
      required String sub_category,
      required String? description,
      required bool availability,
      required String? discounted_price,
      required String price,
      required String? sizes,
      required String? preferred_pieces})
      : super(
            id: id,
            name: name,
            category: category,
            sub_category: sub_category,
            description: description,
            availability: availability,
            discounted_price: discounted_price,
            price: price,
            sizes: sizes,
            preferred_pieces: preferred_pieces);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
