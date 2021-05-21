import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../login/domain/entities/user.dart';
import '../../data/sources/user_cart.dart';

final itemsProvider =
    FutureProvider<Either<Failure, Cart>>((ref) async {
  return await UserCart().getCart();
});
