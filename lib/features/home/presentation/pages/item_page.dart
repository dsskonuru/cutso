import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/error/failures.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/provider/user_firestore_provider.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item.dart';
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
    ItemModel _item = ItemModel.fromJson(json.decode(itemJson));
    List<String> _itemSizes = _item.sizes!.split(',').toList();
    List<String> _itemPreferences = _item.preferred_pieces!.split(',').toList();

    if (orderItemJson != null) {
      OrderItem _orderItem = OrderItem.fromJson(json.decode(orderItemJson!));
      watch(orderItemProvider).setOrderItem(_orderItem);
    }
    OrderItemNotifier orderItemNotifier = watch(orderItemProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
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
              Divider(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_item.name}', style: TextStyle(fontSize: 20.00)),
                      SizedBox(height: 7.00),
                      Text('${_item.sub_category.toUpperCase()}',
                          style: TextStyle(fontSize: 16.00)),
                      SizedBox(height: 12.00),
                      Text("Quantity"),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    orderItemNotifier.decrementQuantity(),
                                icon: Icon(Icons.remove_rounded),
                              ),
                              Text(
                                '${orderItemNotifier.quantity.toStringAsFixed(2)}kg',
                                style: TextStyle(fontSize: 18.00),
                              ),
                              IconButton(
                                onPressed: () =>
                                    orderItemNotifier.incrementQuantity(),
                                icon: Icon(Icons.add_rounded),
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
                      SizedBox(
                        height: 12.00,
                      ),
                      if (_itemSizes.isNotEmpty)
                        Column(
                          children: [
                            Text('Sizes'),
                            MultiSelectChip(
                              _itemSizes,
                              onSelectionChanged: (selectedChips) =>
                                  orderItemNotifier.addTags(selectedChips),
                            ),
                            SizedBox(
                              height: 12.00,
                            ),
                          ],
                        ),
                      if (_itemPreferences.isNotEmpty)
                        Column(
                          children: [
                            Text('Preferred Pieces (Optional)'),
                            MultiSelectChip(
                              _itemPreferences,
                              onSelectionChanged: (selectedChips) =>
                                  orderItemNotifier.addTags(selectedChips),
                            ),
                            SizedBox(
                              height: 12.00,
                            ),
                          ],
                        ),
                      Column(
                        children: [
                          Text('Guidelines (Optional)'),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) =>
                                orderItemNotifier.setGuidelines(value),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.00,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            OrderItem _orderItem = OrderItem(
                              itemId: _item.id,
                              quantity: orderItemNotifier.quantity,
                              tags: orderItemNotifier.tags,
                              guidelines: orderItemNotifier.guidelines,
                              price: double.parse(_item.price) *
                                  2 *
                                  orderItemNotifier.quantity,
                            );
                            late dz.Either<ServerFailure, Cart> _cartOrFailure;
                            await watch(userProvider).getCart().then(
                                (cartOrFailure) =>
                                    _cartOrFailure = cartOrFailure);
                            _cartOrFailure.fold(
                              (failure) {
                                const snackBar =
                                    SnackBar(content: Text('Server Error'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              (cart) async {
                                if (orderItemJson != null) {
                                  cart.orderItems.removeWhere((orderItem) =>
                                      orderItem.itemId == _orderItem.itemId);
                                }
                                cart.add(_orderItem);
                                await watch(userProvider).updateCart(cart);
                                const snackBar =
                                    SnackBar(content: Text('Cart updated'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            );
                          },
                          child: Text('Add to Cart'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
