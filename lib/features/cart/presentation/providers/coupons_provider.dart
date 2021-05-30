import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/coupon_model.dart';
import '../../data/sources/coupons_firestore.dart';

final couponsProvider =
    FutureProvider<Either<ServerFailure, List<CouponModel>>>((ref) async {
  return await CouponsFirestore().getCoupons();
});
