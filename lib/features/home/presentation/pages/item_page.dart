import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../login/data/models/cart.dart';
import '../../../login/data/models/order_item.dart';
import '../../../login/presentation/provider/user_actions_provider.dart';
import '../../data/models/item.dart';
import '../provider/order_items_provider.dart';
import '../widgets/chips.dart';

const Map<String, double> _quantityAdditives = {
  '+100g': 0.1,
  '+250g': 0.25,
  '+500g': 0.5,
  '+1kg': 1.00,
  '+2kg': 2.00,
  '+5kg': 5.00,
};

class ItemPage extends ConsumerWidget {
  final String itemJson;
  final String? orderItemJson;

  const ItemPage({
    @PathParam('itemJson') required this.itemJson,
    @PathParam('orderItemJson') this.orderItemJson,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Item _item =
        Item.fromJson(json.decode(itemJson) as Map<String, dynamic>);
    final List<String> _itemSizes = _item.sizes!.split(',').toList();
    final List<String> _itemPreferences =
        _item.preferredPieces!.split(',').toList();

    if (orderItemJson != null) {
      final OrderItem _orderItem = OrderItem.fromJson(
          json.decode(orderItemJson!) as Map<String, dynamic>);
      context.read(orderItemProvider).setOrderItem(_orderItem);
    }
    final OrderItemNotifier orderItemNotifier = watch(orderItemProvider);
    final Cart cart = watch(userActionsProvider).cart;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: _item.id,
                        child: SvgPicture.asset(
                          'assets/vectors/${getCategoryFromId(_item.id)}.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_item.name, style: const TextStyle(fontSize: 20.00)),
                    const SizedBox(height: 7.00),
                    Text(_item.subCategory.toUpperCase(),
                        style: const TextStyle(fontSize: 16.00)),
                    const SizedBox(height: 12.00),
                    const Text("Quantity"),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  orderItemNotifier.decrementQuantity(),
                              icon: const Icon(Icons.remove_rounded),
                            ),
                            Text(
                              '${orderItemNotifier.quantity.toStringAsFixed(2)}kg',
                              style: const TextStyle(fontSize: 18.00),
                            ),
                            IconButton(
                              onPressed: () =>
                                  orderItemNotifier.incrementQuantity(),
                              icon: const Icon(Icons.add_rounded),
                            ),
                          ],
                        ),
                        SelectChip(
                          _quantityAdditives.keys.toList(),
                          onSelection: (selectedChip) =>
                              orderItemNotifier.incrementQuantity(
                                  _quantityAdditives[selectedChip]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.00,
                    ),
                    if (_itemSizes.isNotEmpty)
                      Column(
                        children: [
                          const Text('Sizes'),
                          MultiSelectChip(
                            _itemSizes,
                            onSelectionChanged: (selectedChips) =>
                                orderItemNotifier.addTags(selectedChips),
                          ),
                          const SizedBox(
                            height: 12.00,
                          ),
                        ],
                      ),
                    if (_itemPreferences.isNotEmpty)
                      Column(
                        children: [
                          const Text('Preferred Pieces (Optional)'),
                          MultiSelectChip(
                            _itemPreferences,
                            onSelectionChanged: (selectedChips) =>
                                orderItemNotifier.addTags(selectedChips),
                          ),
                          const SizedBox(
                            height: 12.00,
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        const Text('Guidelines (Optional)'),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: orderItemNotifier.guidelines,
                          onChanged: (value) =>
                              orderItemNotifier.setGuidelines(value),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.00,
                    ),
                    ElevatedButton(
                        //TODO: seperate tags for sizes and prefered pieces
                        onPressed: () async {
                          final OrderItem _orderItem = OrderItem(
                            itemId: _item.id,
                            quantity: orderItemNotifier.quantity,
                            tags: orderItemNotifier.tags,
                            guidelines: orderItemNotifier.guidelines,
                            price: double.parse(_item.price) *
                                2 *
                                orderItemNotifier.quantity,
                          );
                          if (orderItemJson != null) {
                            cart.orderItems.removeWhere((orderItem) =>
                                orderItem.itemId == _orderItem.itemId);
                          }
                          cart.add(_orderItem);
                          await watch(userActionsProvider).updateCart(cart);
                          const snackBar =
                              SnackBar(content: Text('Cart updated'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Add to Cart'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
