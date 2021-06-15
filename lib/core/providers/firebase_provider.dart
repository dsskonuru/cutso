import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod/riverpod.dart';

import '../../features/cart/data/models/order.dart';
import '../../features/login/data/models/user.dart';

final crashlyticsProvider =
    Provider<FirebaseCrashlytics>((ref) => FirebaseCrashlytics.instance);

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authProvider =
    Provider<fauth.FirebaseAuth>((ref) => fauth.FirebaseAuth.instance);

final usersProvider = Provider<CollectionReference<User>>(
  (ref) => ref.read(firestoreProvider).collection('users').withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      ),
);

final ordersProvider = Provider<CollectionReference<Order>>(
  (ref) =>
      ref.read(firestoreProvider).collection('orders').withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
            toFirestore: (order, _) => order.toJson(),
          ),
);

final couponsProvider = Provider<CollectionReference<Coupon>>(
  (ref) =>
      ref.read(firestoreProvider).collection('coupons').withConverter<Coupon>(
            fromFirestore: (snapshot, _) => Coupon.fromJson(snapshot.data()!),
            toFirestore: (coupon, _) => coupon.toJson(),
          ),
);


