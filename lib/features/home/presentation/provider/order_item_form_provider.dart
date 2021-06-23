import 'package:cutso/core/providers/firebase_provider.dart';
import 'package:cutso/features/home/data/sources/items_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../login/data/models/user.dart';

final orderItemProvider =
    ChangeNotifierProvider.autoDispose((ref) => OrderItemNotifier());

class OrderItemNotifier extends ChangeNotifier {
  int? _itemId;
  double _quantity = 0.5;
  Set<String>? _sizeTags = {};
  Set<String>? _preferenceTags = {};
  String? _guidelines;
  double? _price;
  bool _orderItemSet = false;

  int? get itemId => _itemId;
  double get quantity => _quantity;
  Set<String>? get sizeTags => _sizeTags;
  Set<String>? get preferenceTags => _preferenceTags;
  String? get guidelines => _guidelines;
  double? get price => _price;

  double getOrderItemPrice() {
    double _value = 0.0;
    container.read(itemsRepositoryProvider).getItem(_itemId!).then(
      (itemRunner) {
        itemRunner.fold(
            (failure) =>
                container.read(crashlyticsProvider).log("Unable to fetch data"),
            (item) => _value +=
                (int.parse(item.discountedPrice ?? item.price)) * _quantity);
      },
    );
    return _value;
  }

  OrderItem? get orderItem => OrderItem(
      itemId: _itemId!,
      quantity: _quantity,
      sizeTags: _sizeTags,
      preferenceTags: _preferenceTags,
      guidelines: _guidelines,
      price: _price!);

  void setOrderItem(OrderItem orderItem) {
    if (!_orderItemSet) {
      _itemId = orderItem.itemId;
      _quantity = orderItem.quantity;
      _sizeTags = {};
      _preferenceTags = {};
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

  void addSizeTags(List<String> tags) {
    _sizeTags!.addAll(tags);
    notifyListeners();
  }

  void addPreferenceTags(List<String> tags) {
    _preferenceTags!.addAll(tags);
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
