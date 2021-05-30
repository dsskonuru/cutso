import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../../home/data/models/item_model.dart';
import '../../../home/presentation/widgets/chips.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/provider/user_firestore_provider.dart';

class OrderItemCard extends StatelessWidget {
  final ItemModel item;
  final OrderItem orderItem;

  OrderItemCard(this.item, this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Dismissible(
        child: Card(
          elevation: 7.00,
          child: Padding(
            padding: const EdgeInsets.all(18.00),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 0),
                                blurRadius: 10)
                          ],
                          border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            width: 1,
                          ),
                          image: DecorationImage(
                              //TODO: get image from network
                              image: AssetImage('assets/images/meat.png'),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(50, 50)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${item.sub_category} ${item.name}',
                              style: TextStyle(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.description!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 7.00),
                              child: Text(
                                item.description!,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          SizedBox(
                            height: 7.00,
                          ),
                          Text(
                            "${orderItem.quantity.toString()} kg",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Text(
                        "\u{20B9} ${orderItem.price.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ]),
                DisplayChip(orderItem.tags.toList()),
              ],
            ),
          ),
        ),
        key: ValueKey(item.id),
        background: Container(
          color: Colors.blue,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
            alignment: Alignment.centerLeft,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
            alignment: Alignment.centerRight,
          ),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${item.sub_category} ${item.name}?"),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        context.read(userProvider).cart.orderItems.removeWhere(
                            (_item) => _item.itemId == orderItem.itemId);
                        Cart _cart = context.read(userProvider).cart;
                        Either<ServerFailure, void> updateOrFailure =
                            await context.read(userProvider).updateCart(_cart);
                        if (updateOrFailure.isLeft()) {
                          const snackBar =
                              SnackBar(content: Text('Server Error'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            return res;
          } else {
            await context.router.navigate(
              ItemRoute(
                itemJson: json.encode(item.toJson()),
                orderItemJson: json.encode(orderItem.toJson()),
              ),
            );
          }
        },
      ),
    );
  }
}
