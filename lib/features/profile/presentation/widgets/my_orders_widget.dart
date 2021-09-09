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

class PreviousOrders extends ConsumerWidget {
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final User? user = watch(userActionsProvider).user;

    if (user == null) {
      return Container();
    }

    final Future<dz.Either<Failure, List<Order>>> ordersFuture =
        watch(orderRepositoryProvider).getPreviousOrders(user.orders);

    return FutureBuilder(
      future: ordersFuture,
      builder: (BuildContext context,
          AsyncSnapshot<dz.Either<Failure, List<Order>>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.fold(
            (failure) => Center(
              child: Text(
                'Server Problem',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            (orders) {
              return Column(
                children: <Widget>[
                  ...orders.map((order) => OrderCard(order: order)).toList()
                ],
              );
              // return OrderCards(orders);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        color: kCreamLight,
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: 100.w,
            child: Center(
                child: Column(
              children: [
                Text(order.items.join(' ')),
                const Divider(),
                Text(order.status.toString()),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

// class OrderCards extends StatefulWidget {
//   final List<Order> orders;
//   const OrderCards(this.orders);

//   @override
//   State<OrderCards> createState() => _OrderCardsState();
// }

// class _OrderCardsState extends State<OrderCards> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: 70.h,
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: widget.orders.length,
//         itemBuilder: (BuildContext context, int index) {
//           return
//         },
//       ),
//     );
//   }
// }
