import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/theme/theme_data.dart';

class PriceCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        color: kCreamLight,
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 18.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cart Value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "\u{20B9} ",
                        style:
                            GoogleFonts.roboto().copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text: watch(userActionsProvider)
                            .getCartValue()
                            .toStringAsFixed(2),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
