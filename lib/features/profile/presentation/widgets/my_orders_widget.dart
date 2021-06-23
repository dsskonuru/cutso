import 'package:cutso/core/theme/theme_data.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../cart/data/models/order.dart';
import '../../../login/data/models/user.dart';
import '../../data/sources/orders_repository.dart';

class MyOrdersWidget extends StatefulWidget {
  @override
  State<MyOrdersWidget> createState() => _MyOrdersWidgetState();
}

class _MyOrdersWidgetState extends State<MyOrdersWidget> {
  @override // Rebuild here
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final User? user = watch(userActionsProvider).user;

        if (user == null) {
          return Container();
        }

        final Future<dz.Either<Failure, List<Order>>> ordersFuture =
            watch(orderRepositoryProvider).getMyOrders(user.orders);

        return FutureBuilder(
          future: ordersFuture,
          builder: (BuildContext context,
              AsyncSnapshot<dz.Either<Failure, List<Order>>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.fold(
                (failure) => const Center(
                  child: Text('Server Problem'),
                ),
                (orders) {
                  return OrderCards(orders);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        );
      },
    );
  }
}

class OrderCards extends StatefulWidget {
  final List<Order> orders;
  const OrderCards(this.orders);

  @override
  State<OrderCards> createState() => _OrderCardsState();
}

class _OrderCardsState extends State<OrderCards> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 70.h,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.orders.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: kCreamLight,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 18.h,
                  width: 100.w,
                  child: Center(
                      child: Column(
                    children: [
                      Text(widget.orders[index].orderItems.orderItems.join()),
                      const Divider(),
                      Text(widget.orders[index].status.toString()),
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
