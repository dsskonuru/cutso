import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/tiles.dart';

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
  final DocumentSnapshot? userProfile;

  const HomePage({Key? key, this.userProfile}) : super(key: key);

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
        leading: Icon(
          Icons.menu,
          size: 30.0,
          color: Colors.amber,
        ),
        title: Image(
          height: 36.0,
          image: AssetImage('assets/images/cutso-text-small.png'),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ChickenWidget(),
                MuttonWidget(),
                SeaFoodWidget(),
                ReadyToCookWidget(),
                EggsNSidesWidget(),
                BestDealsWidget(),
              ],
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
          ),
        ),
      ),
    );
  }
}
