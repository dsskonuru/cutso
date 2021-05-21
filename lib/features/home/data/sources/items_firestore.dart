import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutso/features/home/data/models/item_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class ItemsDataSource {
  Future<Either<Failure, List<ItemModel>>> getItems();
}

class ItemsFirestore implements ItemsDataSource {
  @override
  Future<Either<Failure, List<ItemModel>>> getItems() async {
    try {
      List<ItemModel> items = [];
      await FirebaseFirestore.instance
          .collection('items')
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        querySnapshot.docs
            .forEach((QueryDocumentSnapshot<Map<String, dynamic>> item) {
          items.add(ItemModel.fromJson(item.data()));
        });
      });
      return Right(items);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
