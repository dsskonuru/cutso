import 'package:dartz/dartz.dart' as dz;
import 'package:riverpod/riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main_common.dart';
import '../../../cart/data/models/order.dart';

abstract class OrderDataSource {
  Future<dz.Either<Failure, void>> pushOrder(Order order);
  Future<dz.Either<Failure, List<Order>>> getMyOrders(List<String> myOrderIds);
}

final orderRepositoryProvider =
    Provider<OrderRepository>((ref) => OrderRepository());

class OrderRepository implements OrderDataSource {
  @override
  Future<dz.Either<Failure, void>> pushOrder(Order order) async {
    try {
      late dz.Either<Failure, void> _orderRef;
      await container
          .read(ordersProvider)
          .doc(order.orderId)
          .set(order)
          .then((value) => _orderRef = const dz.Right(null))
          .catchError(
        (error) {
          _orderRef = dz.Left(ServerFailure(error.toString()));
        },
      );
      return _orderRef;
    } on Exception {
      return dz.Left(
        ServerFailure("Unable to push the order"),
      );
    }
  }

  @override
  Future<dz.Either<Failure, List<Order>>> getMyOrders(
      List<String> myOrderIds) async {
    try {
      late dz.Either<Failure, List<Order>> _myOrdersRef;
      final List<Order> orders = [];
      // TODO: Currently gets only last 10 orders
      final List<String> orderIds;
      if (myOrderIds.length >= 10) {
        orderIds = myOrderIds.sublist(0, 10);
      } else {
        orderIds = myOrderIds;
      }
      await container
          .read(ordersProvider)
          .where("orderId", whereIn: orderIds)
          .get()
          .then((queries) {
        for (final element in queries.docs) {
          orders.add(element.data());
        }
        return _myOrdersRef = dz.Right(orders);
      }).catchError(
        (error) {
          _myOrdersRef = dz.Left(ServerFailure(error.toString()));
        },
      );
      return _myOrdersRef;
    } on Exception {
      return dz.Left(
        ServerFailure("Unable to push the order"),
      );
    }
  }
}
