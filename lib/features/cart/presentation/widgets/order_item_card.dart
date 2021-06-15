import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../home/data/models/item.dart';
import '../../../home/presentation/widgets/chips.dart';
import '../../../login/data/models/user.dart';

class OrderItemCard extends ConsumerWidget {
  final Item item;
  final OrderItem orderItem;

  const OrderItemCard(this.item, this.orderItem);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Dismissible(
        key: ValueKey(item.id),
        background: Container(
          color: Colors.blue,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                Text(
                  " Edit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  " Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final bool? res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${item.subCategory} ${item.name}?"),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        watch(userActionsProvider).cart.orderItems.removeWhere(
                            (_item) => _item.itemId == orderItem.itemId);
                        final Cart _cart = watch(userActionsProvider).cart;
                        watch(userActionsProvider).cart = _cart;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            return res!;
          } else {
            await context.router.navigate(
              ItemRoute(
                itemJson: json.encode(item.toJson()),
                orderItemJson: json.encode(orderItem.toJson()),
              ),
            );
          }
        },
        child: Card(
          elevation: 5.0,
          child: SizedBox(
            // height: 180.0,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/meat.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   width: 72,
                            //   height: 72,
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //           color: Color.fromRGBO(0, 0, 0, 0.3),
                            //           offset: Offset(0, 0),
                            //           blurRadius: 10)
                            //     ],
                            //     border: Border.all(
                            //       color: Color.fromRGBO(255, 255, 255, 1),
                            //       width: 1,
                            //     ),
                            //     image: DecorationImage(
                            //         //TODO: get image from network
                            //         image: AssetImage('assets/images/meat.png'),
                            //         fit: BoxFit.cover),
                            //     borderRadius:
                            //         BorderRadius.all(Radius.elliptical(50, 50)),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Text(
                                  '${item.subCategory} ${item.name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                ),
                                if (item.description!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.00),
                                    child: Text(
                                      item.description!,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 7.00,
                                ),
                                Text(
                                  "${orderItem.quantity.toString()} kg",
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Text(
                              "\u{20B9} ${orderItem.price.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ]),
                      if (orderItem.sizeTags != null)
                        DisplayChip(orderItem.sizeTags!.toList()),
                      if (orderItem.preferenceTags != null)
                        DisplayChip(orderItem.preferenceTags!.toList()),
                      if (orderItem.guidelines != null)
                        Text(orderItem.guidelines!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
