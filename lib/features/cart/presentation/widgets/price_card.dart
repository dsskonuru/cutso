import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/user_actions_provider.dart';

class PriceCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double value = 0.0;
    for (final orderItem in watch(userActionsProvider).cart.orderItems) {
      value += orderItem.price;
    }

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cart Value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\u{20B9} ${value.toString()}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
