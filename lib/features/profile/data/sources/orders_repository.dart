import 'package:dartz/dartz.dart' as dz;
import 'package:riverpod/riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main_common.dart';
import '../../../cart/data/models/order.dart';
import '../../../login/data/models/user.dart';

abstract class OrderDataSource {
  Future<dz.Either<Failure, void>> pushOrder(Order order);
  Future<dz.Either<Failure, List<Order>>> getMyOrders(MyOrders myOrders);
  // Future<dz.Either<Failure, void>> initatePayment(String orderId);
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
  Future<dz.Either<Failure, List<Order>>> getMyOrders(MyOrders myOrders) async {
    try {
      late dz.Either<Failure, List<Order>> _myOrdersRef;
      final List<Order> orders = [];
      await container
          .read(ordersProvider)
          .where("orderId", whereIn: myOrders.orderIds.sublist(0, 5))
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
