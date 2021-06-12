import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/data/models/order_item.dart';

final orderItemProvider =
    ChangeNotifierProvider.autoDispose((ref) => OrderItemNotifier());

class OrderItemNotifier extends ChangeNotifier {
  //TODO: create orders page
  int? _itemId;
  double _quantity = 0.5;
  Set<String> _tags = {}; // includes sizes and preferences
  String? _guidelines;
  double? _price;
  bool _orderItemSet = false;

  int? get itemId => _itemId;
  double get quantity => _quantity;
  Set<String> get tags => _tags;
  String? get guidelines => _guidelines;
  double? get price => _price;

  OrderItem? get orderItem => OrderItem(
      itemId: _itemId!,
      quantity: _quantity,
      tags: _tags,
      guidelines: _guidelines,
      price: _price!);

  void setOrderItem(OrderItem orderItem) {
    if (!_orderItemSet) {
      _itemId = orderItem.itemId;
      _quantity = orderItem.quantity;
      _tags = orderItem.tags;
      _guidelines = orderItem.guidelines;
      _price = orderItem.price;
      _orderItemSet = true;
    }
  }

  // void resetOrderItem() {
  //   _itemId = null;
  //   _quantity = 0.5;
  //   _tags = {};
  //   _guidelines = null;
  //   _price = null;
  //   _orderItemSet = false;
  // }

  void setitemId(int itemId) {
    _itemId = itemId;
    notifyListeners();
  }

  void setQuantity(double quantity) {
    _quantity = quantity;
    debugPrint(_quantity.toString());
    notifyListeners();
  }

  void incrementQuantity([double? amount]) {
    final double _inc = amount ?? 0.5;
    setQuantity(_quantity + _inc);
  }

  void decrementQuantity() {
    setQuantity(_quantity - 0.5);
  }

  void addTags(List<String> tags) {
    _tags.addAll(tags);
    notifyListeners();
  }

  void setGuidelines(String guidelines) {
    _guidelines = guidelines;
    notifyListeners();
  }

  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }
}
