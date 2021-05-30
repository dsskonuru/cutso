import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/item_model.dart';
import '../../../home/presentation/provider/items_provider.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/provider/user_firestore_provider.dart';
import 'order_item_card.dart';

class OrderSummary extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Cart cart = watch(userProvider).cart;

    List<Widget> orderItemList = [];
    for (int i = 0; i < cart.orderItems.length; i++) {
      OrderItem orderItem = cart.orderItems[i];
      Future<dz.Either<ServerFailure, ItemModel>> futureItem =
          watch(itemsProvider).getItem(orderItem.itemId);
      orderItemList.add(
        FutureBuilder(
          future: futureItem,
          builder: (BuildContext context,
              AsyncSnapshot<dz.Either<ServerFailure, ItemModel>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.fold(
                (failure) => Center(
                  child: const Text('Server Problem'),
                ),
                (item) {
                  return OrderItemCard(item, orderItem);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      );
    }
    return Column(
      children: orderItemList,
    );
  }
}
