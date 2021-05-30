import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/domain/entities/user.dart';

class OrderItemNotifier extends ChangeNotifier {
  int? _itemId;
  double _quantity = 0.5;
  Set<String> _tags = {}; // includes sizes and preferences
  String? _guidelines;
  double? _price;

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

  void setitemId(int itemId) {
    _itemId = itemId;
    notifyListeners();
  }

  void setQuantity(double quantity) {
    _quantity = quantity;
    notifyListeners();
  }

  void incrementQuantity([double? amount]) {
    _quantity += amount ?? 0.5;
    notifyListeners();
  }

  void decrementQuantity() {
    _quantity -= 0.5;
    notifyListeners();
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

  void setOrderItem(OrderItem orderItem) {
    _itemId = orderItem.itemId;
    _quantity = orderItem.quantity;
    _tags = orderItem.tags;
    _guidelines = orderItem.guidelines;
    _price = orderItem.price;
    notifyListeners();
  }
}

final orderItemProvider = ChangeNotifierProvider((ref) => OrderItemNotifier());
