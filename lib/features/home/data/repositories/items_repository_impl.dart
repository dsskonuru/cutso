// import 'package:dartz/dartz.dart';

// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../domain/repositories/items_repository.dart';
// import '../datasources/items_firestore.dart';
// import '../models/item_model.dart';

// class ItemsRepositoryImpl implements ItemsRepository {
//   final ItemsDataSource itemsDataSource;

//   ItemsRepositoryImpl({
//     required this.itemsDataSource,
//   });

//   @override
//   Future<Either<Failure, List<ItemModel>>> getItems() async {
//     try {
//       final items = await itemsDataSource.getItems();
//       return Right(items);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
// }
