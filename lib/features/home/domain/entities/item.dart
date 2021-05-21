import 'package:equatable/equatable.dart';

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

class Item extends Equatable {
  final int? id;
  final String? name;
  final String? category;
  final String? sub_category;
  final String? description;
  final bool? availability;
  final String? discounted_price;
  final String? price;
  final String? tags;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.sub_category,
    required this.description,
    required this.availability,
    required this.discounted_price,
    required this.price,
    required this.tags,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        name,
        category,
        sub_category,
        description,
        availability,
        discounted_price,
        price,
        tags,
      ];
}
