import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../main.dart';
import '../models/item.dart';

abstract class ItemsDataSource {
  Future<Either<ServerFailure, List<Item>>> getItemsList();
  Future<Either<ServerFailure, Item>> getItem(int itemId);
}

final itemsRepositoryProvider =
    Provider<ItemsRepository>((ref) => ItemsRepository());

class ItemsRepository implements ItemsDataSource {
  final _itemsRef =
      container.read(firestoreProvider).collection('items').withConverter<Item>(
            fromFirestore: (snapshot, _) => Item.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          );

  @override
  Future<Either<ServerFailure, List<Item>>> getItemsList() async {
    try {
      final List<Item> _items = [];
      await _itemsRef.get().then((QuerySnapshot<Item> itemQuerySnapshot) {
        for (final itemQueryDocumentSnapshot in itemQuerySnapshot.docs) {
          _items.add(itemQueryDocumentSnapshot.data());
        }
      });
      return Right(_items);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, Item>> getItem(int itemId) async {
    try {
      late Item _item;
      await _itemsRef.doc(itemId.toString()).get().then(
          (DocumentSnapshot<Item> itemDocumentSnapshot) =>
              _item = itemDocumentSnapshot.data()!);
      return Right(_item);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
