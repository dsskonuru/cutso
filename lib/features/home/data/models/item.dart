import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  @JsonSerializable(explicitToJson: true)
  factory Item({
    required int id,
    required String name,
    required String category,
    required String subCategory,
    required bool availability,
    required String price,
    required String? description,
    required String? discountedPrice,
    required String? sizes,
    required String? preferredPieces,
  }) = _Item;
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

const Map<String, Map<String, dynamic>> categories = {
  "sea-food": {
    "name": "Sea Food",
    "sub_categories": ['Fresh Water', 'Marine Fish', 'Shell Fish', 'Fillets'],
  },
  "bird": {
    "name": "Bird",
    "sub_categories": ['Chicken', 'Desi Chicken', 'Other Birds'],
  },
  "mutton": {
    "name": "Mutton",
    "sub_categories": ['Goat', 'Lamb'],
  },
  "eggs-n-sides": {
    "name": "Eggs & Sides",
    "sub_categories": [],
  },
  "ready-to-cook": {
    "name": "Ready to Cook",
    "sub_categories": [],
  },
  "best-deals": {
    "name": "Best Deals",
    "sub_categories": [],
  },
};

String getCategoryFromId(int itemId) {
  switch (itemId ~/ 100000) {
    case 1:
      return "sea-food";
    case 2:
      return "bird";
    case 3:
      return 'mutton';
    case 4:
      return 'eggs-n-sides';
    case 5:
      return 'ready-to-cook';
    case 6:
      return 'best-deals';
    default:
      return 'bird';
  }
}
