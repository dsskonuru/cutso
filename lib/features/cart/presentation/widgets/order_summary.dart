import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../home/data/models/item.dart';
import '../../../home/data/sources/items_repository.dart';
import '../../../login/data/models/user.dart';
import 'order_item_card.dart';

class OrderSummary extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Cart cart = watch(userActionsProvider).cart;

    final List<Widget> orderItemList = [];
    for (int i = 0; i < cart.orderItems.length; i++) {
      final OrderItem orderItem = cart.orderItems[i];
      final Future<dz.Either<ServerFailure, Item>> futureItem =
          watch(itemsRepositoryProvider).getItem(orderItem.itemId);
      orderItemList.add(
        FutureBuilder(
          future: futureItem,
          builder: (BuildContext context,
              AsyncSnapshot<dz.Either<ServerFailure, Item>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.fold(
                (failure) => const Center(
                  child: Text('Server Problem'),
                ),
                (item) {
                  return OrderItemCard(item, orderItem);
                },
              );
            } else {
              return const Center(
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
