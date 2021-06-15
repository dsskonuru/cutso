import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../login/data/models/user.dart';
import '../widgets/address_card.dart';
import '../widgets/order_summary.dart';
import '../widgets/payment_card.dart';
import '../widgets/price_card.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Center(
                    child: Text(
                      'Checkout',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              OrderSummary(),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'Address Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              AddressCard(),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'Price Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              PriceCard(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              PaymentCard(),
              Consumer(
                builder: (context, watch, child) {
                  return ArgonButton(
                    height: 9.w,
                    width: 36.w,
                    color: kOrange,
                    borderRadius: 0.5.w,
                    loader: Container(
                      padding: const EdgeInsets.all(10),
                      child: const SpinKitRotatingCircle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: (startLoading, stopLoading, btnState) async {
                      if (btnState == ButtonState.Idle) {
                        startLoading();
                        final cart = watch(userActionsProvider).cart;
                        if (cart.orderItems.isNotEmpty) {
                          final orderRunner =
                              await watch(userActionsProvider).placeOrder(cart);
                          orderRunner.fold(
                            (failure) {
                              watch(crashlyticsProvider)
                                  .log(failure.messsage.toString());
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                  message:
                                      "We're unable to place the order, please try again later",
                                ),
                              );
                            },
                            (_) {
                              setState(() {});
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.success(
                                  message: "Order was placed successfully !",
                                ),
                              );
                              watch(userActionsProvider)
                                  .updateCart(Cart(orderItems: []));
                            },
                          );
                          stopLoading();
                        } else {
                          await context.router.navigate(const HomeRoute());
                          stopLoading();
                        }
                      }
                    },
                    // color: Color(0xFF7866FE),
                    child: Text(
                      'Place Order',
                      style: Theme.of(context).textTheme.button,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
