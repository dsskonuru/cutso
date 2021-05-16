import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/streams.dart';

CollectionReference products =
    FirebaseFirestore.instance.collection('products');

// Future<void> updateDB(products, length) async {
//   for (var i = 1; i <= length; i++) {
//     if (i%3==0) {
//       products
//           .doc("shell-fish")
//           .update({'item$i.discountedPrice ':  100})
//           .then((value) => print("Products Updated"))
//           .catchError((error) => print("Failed to products: $error"));
//     }
//   }
// }

Stream<List<DocumentSnapshot>> chickenStream() {
  return CombineLatestStream.combine3(
    products.doc("chicken").snapshots(),
    products.doc("chicken-desi").snapshots(),
    products.doc("other-chicken").snapshots(),
    (DocumentSnapshot s1, DocumentSnapshot s2, DocumentSnapshot s3) =>
        [s1, s2, s3],
  );
}

class ChickenListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<DocumentSnapshot>>(
        stream: chickenStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          Map<String, dynamic>? chickenData = snapshot.data![0].data();
          Map<String, dynamic>? chickenDesiData = snapshot.data![1].data();
          Map<String, dynamic>? otherChickenData = snapshot.data![2].data();

          // debugPrint(data.length.toString());
          // updateDB(products, data.length);

          return Expanded(
            child: ListView(
              children: [
                for (Map<String, dynamic>? data in [
                  chickenData,
                  chickenDesiData,
                  otherChickenData
                ])
                  for (var key in data!.keys.toList()..sort())
                    ListTile(
                      title: Text(
                        data[key]["name"].toString(),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: (data[key]["description"] != null)
                          ? Text(
                              data[key]["description"].toString(),
                              style: TextStyle(fontSize: 12),
                            )
                          : null,
                      enabled: data[key]["available"] ?? true,
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 0),
                                blurRadius: 10)
                          ],
                          border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            width: 1,
                          ),
                          image: DecorationImage(
                              image: AssetImage('assets/images/meat.png'),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(50, 50)),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Text(
                              "500gm",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            (data[key]["discountedPrice"] != null)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$" + data[key]["price"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "\$" +
                                            data[key]["discountedPrice"]
                                                .toString(),
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 10.0),
                                      )
                                    ],
                                  )
                                : Text(
                                    "\$" + data[key]["price"].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                          ],
                        ),
                      ),
                    ),
              ],
            ),
            // child: Text(data.toString()),
          );
        },
      ),
    );
  }
}

class ChickenPage extends StatefulWidget {
  @override
  _ChickenPageState createState() => _ChickenPageState();
}

class _ChickenPageState extends State<ChickenPage> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: () => AutoRouter.of(context).pop(),
                  icon: Icon(Icons.arrow_back_rounded),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Hero(
                          tag: 'chicken',
                          child: SvgPicture.asset('assets/vectors/chicken.svg',
                              semanticsLabel: 'chicken'),
                        ),
                      ),
                      Text(
                        'Chicken',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            ChickenListView(),
          ],
        ),
      ),
    );
  }
}
