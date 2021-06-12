import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../widgets/category_tiles.dart';

class CartNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value += 1;
    notifyListeners();
  }
}

final cartProvider = ChangeNotifierProvider((ref) => CartNotifier());

class HomePage extends StatefulWidget {
  // final DocumentSnapshot? userProfile;

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> documentStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          size: 30.00,
          color: Colors.amber,
        ),
        title: const Image(
          height: 36.00,
          image: AssetImage('assets/images/cutso-text-small.png'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.navigate(const CartRoute()),
        child: const Icon(Icons.shopping_cart_rounded),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: GridView.count(
            crossAxisCount: 2,
            // crossAxisSpacing: 5,
            // mainAxisSpacing: 5,
            children: const [
              CategoryWidget(itemCategory: 'bird'),
              CategoryWidget(itemCategory: 'mutton'),
              CategoryWidget(itemCategory: 'sea-food'),
              CategoryWidget(itemCategory: 'eggs-n-sides'),
              CategoryWidget(itemCategory: 'ready-to-cook'),
              CategoryWidget(itemCategory: 'best-deals'),
            ],
          ),
        ),
      ),
    );
  }
}
