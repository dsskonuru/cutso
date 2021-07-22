import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cutso/core/providers/firebase_provider.dart';
import 'package:cutso/core/providers/user_actions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../widgets/address_card_widget.dart';
import '../widgets/order_summary_card_widget.dart';
import '../widgets/payment_card_widget.dart';
import '../widgets/price_card_widget.dart';

const String errorMessage =
    "We're unable to place the order, please try again later";

const String successMessage = "Order was placed successfully !";

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _CheckoutHeader(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              OrderSummary(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Address Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              AddressCard(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Price Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              PriceCard(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              PaymentCard(),
              SizedBox(height: 2.h),
              Consumer(
                builder: (context, watch, child) {
                  return ArgonButton(
                    height: 9.w,
                    width: 45.w,
                    color: kOrange,
                    borderRadius: 5.w,
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
                          // context.router.navigate(const PaymentRoute());
                          orderRunner.fold(
                            (failure) {
                              watch(crashlyticsProvider)
                                  .log(failure.messsage.toString());
                          showTopSnackBar(
                              context,
                              const CustomSnackBar.error(
                                  message: errorMessage));
                          },
                          (_) {
                            setState(() {});
                          showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                  message: successMessage));
                            },
                          );
                          stopLoading();
                        } else {
                          await context.router.navigate(const HomeRoute());
                          stopLoading();
                        }
                      }
                    },
                    child: Text(
                      'PLACE ORDER',
                      style: Theme.of(context).textTheme.button,
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutHeader extends StatelessWidget {
  const _CheckoutHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_rounded),
              Text(
                ' Checkout',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
