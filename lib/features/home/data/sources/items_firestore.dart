import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/item_model.dart';

abstract class ItemsDataSource {
  Future<Either<ServerFailure, List<ItemModel>>> getItems();
  Future<Either<ServerFailure, ItemModel>> getItem(int itemId);
}

class ItemsFirestore implements ItemsDataSource {
  final _itemsRef = FirebaseFirestore.instance
      .collection('items')
      .withConverter<ItemModel>(
        fromFirestore: (snapshot, _) => ItemModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Future<Either<ServerFailure, List<ItemModel>>> getItems() async {
    try {
      List<ItemModel> _items = [];
      await _itemsRef.get().then((QuerySnapshot<ItemModel> itemQuerySnapshot) {
        itemQuerySnapshot.docs.forEach(
            (QueryDocumentSnapshot<ItemModel> itemQueryDocumentSnapshot) {
          _items.add(itemQueryDocumentSnapshot.data());
        });
      });
      return Right(_items);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, ItemModel>> getItem(int itemId) async {
    try {
      late ItemModel _item;
      await _itemsRef.doc(itemId.toString()).get().then(
          (DocumentSnapshot<ItemModel> itemDocumentSnapshot) =>
              _item = itemDocumentSnapshot.data()!);
      return Right(_item);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
