import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../cart/data/models/coupon_model.dart';

abstract class CouponsDataSource {
  Future<Either<ServerFailure, List<CouponModel>>> getCoupons();
}

class CouponsFirestore implements CouponsDataSource {
  final _couponsRef = FirebaseFirestore.instance
      .collection('coupons')
      .withConverter<CouponModel>(
        fromFirestore: (snapshot, _) => CouponModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Future<Either<ServerFailure, List<CouponModel>>> getCoupons() async {
    try {
      List<CouponModel> coupons = [];
      await _couponsRef
          .get()
          .then((QuerySnapshot<CouponModel> couponQuerySnapshot) {
        couponQuerySnapshot.docs.forEach(
            (QueryDocumentSnapshot<CouponModel> couponQueryDocumentSnapshot) {
          coupons.add(couponQueryDocumentSnapshot.data());
        });
      });
      return Right(coupons);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
