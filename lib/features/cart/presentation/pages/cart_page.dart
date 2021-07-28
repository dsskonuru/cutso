import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../main_common.dart';
import '../../../login/data/models/user.dart';
import '../widgets/address_card_widget.dart';
import '../widgets/order_summary_card_widget.dart';
import '../widgets/price_card_widget.dart';
import '../widgets/schedule_delivery_widget.dart';

const String errorMessage =
    "We're unable to place the order, please try again later";

const String successMessage = "Order was placed successfully !";

const String loginMessage = "Please Login to place your order";

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
                  'Delivery Address',
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
                  'Schedule Delivery',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ScheduleDelivery(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(height: 2.h),
              ArgonButton(
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
                    final List<CartItem> cart =
                        container.read(userActionsProvider).cart;
                    if (cart.isNotEmpty) {
                      final orderRunner = await container
                          .read(userActionsProvider)
                          .placeOrder();
                      orderRunner.fold(
                        (failure) {
                          if (container.read(userActionsProvider).user ==
                              null) {
                            showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                    message: loginMessage));
                          } else {
                            showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                    message: errorMessage));
                          }
                        },
                        (orderPlaced) {
                          if (orderPlaced == true) {
                            showTopSnackBar(
                                context,
                                const CustomSnackBar.success(
                                    message: successMessage));
                          } else {
                            if (container.read(userActionsProvider).user ==
                                null) {
                              showTopSnackBar(
                                  context,
                                  const CustomSnackBar.error(
                                      message: loginMessage));
                            } else {
                              showTopSnackBar(
                                  context,
                                  const CustomSnackBar.error(
                                      message: errorMessage));
                            }
                          }
                        },
                      );
                      stopLoading();
                    } else {
                      await context.router.navigate(const HomeRoute());
                      stopLoading();
                    }
                    setState(() {}); // TODO: NOT WORKING
                  }
                },
                child: Text(
                  'PLACE ORDER',
                  style: Theme.of(context).textTheme.button,
                ),
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
