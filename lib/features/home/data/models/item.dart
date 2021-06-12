import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item extends Equatable {
   final int id;
  final String name;
  final String category;
  final String subCategory;
  final String? description;
  final bool availability;
  final String? discountedPrice;
  final String price;
  final String? sizes;
  final String? preferredPieces;

  const Item({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.description,
    required this.availability,
    required this.discountedPrice,
    required this.price,
    required this.sizes,
    required this.preferredPieces,
  });

  @override
  List<Object?> get props => [
        name,
        category,
        subCategory,
        description,
        availability,
        discountedPrice,
        price,
        sizes,
        preferredPieces,
      ];

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
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
