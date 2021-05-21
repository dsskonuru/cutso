import 'dart:convert';
import 'package:cutso/features/home/data/models/item_model.dart';
import 'package:cutso/features/home/domain/entities/item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tItem = ItemModel(
      id: 101001,
      name: "Koramennu",
      category: "Sea Food",
      sub_category: "Fresh Water",
      description: "Murrel / Maral / Motta",
      availability: true,
      discounted_price: "100",
      price: "200",
      tags: "");

  test(
    'should be a subclass of Item entity',
    () async {
      // assert
      expect(tItem, isA<Item>());
    },
  );

  test(
    'should return a valid model when given JSON',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));
      // act
      final result = ItemModel.fromJson(jsonMap);
      // assert
      expect(result, tItem);
    },
  );

  test(
    'should return a JSON map containing the proper data',
    () async {
      // act
      final result = tItem.toJson();
      // assert
      final expectedMap = {
        "availability": true,
        "category": "Sea Food",
        "description": "Murrel / Maral / Motta",
        "discounted_price": 100,
        "name": "Koramennu",
        "price": 200,
        "sub_category": "Fresh Water",
        "tags": ""
      };
      expect(result, expectedMap);
    },
  );
}
