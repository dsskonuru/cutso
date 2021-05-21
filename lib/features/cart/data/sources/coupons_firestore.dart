import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../cart/data/models/coupon_model.dart';

abstract class CouponsDataSource {
  Future<Either<Failure, List<CouponModel>>> getCoupons();
}

class CouponsFirestore implements CouponsDataSource {
  @override
  Future<Either<Failure, List<CouponModel>>> getCoupons() async {
    try {
      List<CouponModel> coupons = [];
      await FirebaseFirestore.instance
          .collection('coupons')
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        querySnapshot.docs
            .forEach((QueryDocumentSnapshot<Map<String, dynamic>> coupon) {
          coupons.add(CouponModel.fromJson(coupon.data()));
        });
      });
      return Right(coupons);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
