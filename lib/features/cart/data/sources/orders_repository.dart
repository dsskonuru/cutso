import 'package:dartz/dartz.dart' as dz;
import 'package:riverpod/riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main.dart';
import '../models/order.dart';

abstract class OrderDataSource {
  Future<dz.Either<Failure, void>> pushOrder(Order order); // returns orderId
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
}
