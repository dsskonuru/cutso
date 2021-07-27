import 'package:cutso/features/home/data/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/data/models/user.dart';

final cartItemProvider =
    ChangeNotifierProvider.autoDispose((ref) => CartItemNotifier());

class CartItemNotifier extends ChangeNotifier {
  bool cartItemSet = false;

  CartItem get cartItem => CartItem(
        itemId: item!.id,
        quantity: quantity,
        sizeTag: sizeTag,
        preferenceTags: preferenceTags,
        guidelines: guidelines,
        price: price,
      );
  set cartItem(CartItem myCartItem) {
    if (!cartItemSet) {
      quantity = myCartItem.quantity;
      sizeTag = myCartItem.sizeTag;
      preferenceTags = myCartItem.preferenceTags;
      guidelines = myCartItem.guidelines;
      cartItemSet = true;
    }
  }

  Item? _item;
  Item? get item => _item;
  set item(Item? item) {
    _item = item;
    notifyListeners();
  }

  double _quantity = 0.5;
  double get quantity => _quantity;
  set quantity(double quantity) {
    if (quantity < 0) {
      _quantity = 0.0;
    } else {
      _quantity = quantity;
    }
    debugPrint(_quantity.toString()); // !
    notifyListeners();
  }

  void incrementQuantity([double? amount]) =>
      quantity = _quantity + (amount ?? 0.5);
  void decrementQuantity() => quantity = _quantity - 0.5;

  String? _sizeTag;
  String? get sizeTag => _sizeTag;
  set sizeTag(String? sizeTag) {
    _sizeTag = sizeTag;
    notifyListeners();
  }

  Set<String>? _preferenceTags;
  Set<String>? get preferenceTags => _preferenceTags;
  set preferenceTags(Set<String>? tags) {
    _preferenceTags = tags;
    notifyListeners();
  }

  String? _guidelines;
  String get guidelines => _guidelines ?? "";
  set guidelines(String? guidelines) {
    _guidelines = guidelines;
    notifyListeners();
  }

  double get price {
    if (item!.discountedPrice != null && item!.discountedPrice!.isNotEmpty) {
      return double.parse(item!.discountedPrice!) * 2 * quantity;
    }
    return double.parse(item!.price) * 2 * quantity;
  }
}
