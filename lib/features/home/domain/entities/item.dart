import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int? document_id;
  final String? name;
  final String? category;
  final String? sub_category;
  final String? description;
  final bool? availability;
  final String? discounted_price;
  final String? price;
  final String? tags;

  Item({
    required this.document_id,
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
