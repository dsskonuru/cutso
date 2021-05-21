import '../../data/sources/items_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/item_model.dart';

final itemsProvider =
    FutureProvider<Either<Failure, List<ItemModel>>>((ref) async {
  return await ItemsFirestore().getItems();
});
