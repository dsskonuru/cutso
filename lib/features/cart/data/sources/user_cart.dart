import '../../../login/data/sources/users_firestore.dart';
import '../../../login/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class CartSource {
  Future<Either<Failure, Cart>> getCart();
  Future<Either<Failure, void>> updateCart(Cart cart);
}

class UserCart implements CartSource {
  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      Cart? cart = UserFirestore().user!.cart;
      return Right(cart!);
    } on UserNotLoggedInException {
      return Left(UserNotLoggedInFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateCart(Cart cart) async {
    if (UserFirestore().user != null) {
      UserFirestore().updateUserCart(cart);
      return Right(cart);
    }
    return Left(UserNotLoggedInFailure());
  }
}
