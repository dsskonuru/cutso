// import 'package:cutso/core/error/failures.dart';
// import 'package:cutso/features/home/data/datasources/items_firestore.dart';
// import 'package:cutso/features/home/data/models/item_model.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';

// // class MockItemsFirestore extends Mock implements ItemsFirestore {}

// void main() {
//   // final ItemsFirestore itemsFirestore;

//   // setUp(() {
//   //   itemsFirestore = ItemsFirestore();
//   // });

//   // void setUpMockRepositorySuccess() {
//   //   when(mockItemsFirestore.getItems())
//   //       .thenAnswer((_) async => );
//   // }

//   void initializeFlutterFire() async {
//     try {
//       await Firebase.initializeApp();
//       setState(() {
//         _initialized = true;
//       });
//     } catch (e) {
//       setState(() {
//         _error = true;
//       });
//     }
//   }

//   group('firestore', () {
//     final Firebase.initializeApp();
//     final itemsFirestore = ItemsFirestore();
//     final Future<Either<Failure, List<ItemModel>>> items =
//         itemsFirestore.getItems();

//     test(
//       '''check get items''',
//       () async {
//         print(items.asStream()..first.toString());

//         // arrange
//         // setUp();
//         // act
//         // dataSource.getConcreteNumberTrivia(tNumber);
//         // assert
//         // verify(mockHttpClient.get(
//         //   'http://numbersapi.com/$tNumber',
//         //   headers: {
//         //     'Content-Type': 'application/json',
//         //   },
//         // ));
//       },
//     );
//   });
// }
