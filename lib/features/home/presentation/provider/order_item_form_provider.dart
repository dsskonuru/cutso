import 'package:cutso/features/home/data/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/data/models/user.dart';

final orderItemProvider =
    ChangeNotifierProvider.autoDispose((ref) => OrderItemNotifier());

class OrderItemNotifier extends ChangeNotifier {
  bool orderItemSet = false;

  OrderItem get orderItem => OrderItem(
        itemId: item!.id,
        quantity: quantity,
        sizeTag: sizeTag,
        preferenceTags: preferenceTags,
        guidelines: guidelines,
        price: price,
      );
  set orderItem(OrderItem myOrderItem) {
    if (!orderItemSet) {
      quantity = myOrderItem.quantity;
      sizeTag = myOrderItem.sizeTag;
      preferenceTags = myOrderItem.preferenceTags;
      guidelines = myOrderItem.guidelines;
      orderItemSet = true;
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
