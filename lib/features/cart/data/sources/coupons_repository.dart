import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main.dart';
import '../models/order.dart';

abstract class CouponsDataSource {
  Future<Either<Failure, List<Coupon>>> getCoupons();
}

class CouponsRepository implements CouponsDataSource {
  @override
  Future<Either<Failure, List<Coupon>>> getCoupons() async {
    try {
      final List<Coupon> coupons = [];
      await container
          .read(couponsProvider)
          .get()
          .then((QuerySnapshot<Coupon> couponQuerySnapshot) {
        for (final couponQueryDocumentSnapshot in couponQuerySnapshot.docs) {
          coupons.add(couponQueryDocumentSnapshot.data());
        }
      });
      return Right(coupons);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
