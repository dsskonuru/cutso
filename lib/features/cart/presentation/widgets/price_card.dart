import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/presentation/provider/user_firestore_provider.dart';

class PriceCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double value = 0.0;
    watch(userProvider)
        .cart
        .orderItems
        .forEach((orderItem) => value += orderItem.price);

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cart Value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\u{20B9} ${value.toString()}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
