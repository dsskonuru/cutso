import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cutso/features/home/presentation/provider/order_item_form_provider.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../home/data/models/item.dart';
import '../../../home/data/sources/items_repository.dart';
import '../../../home/presentation/widgets/chips_widget.dart';
import '../../../login/data/models/user.dart';

class OrderSummary extends StatefulWidget {
  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override // Rebuild here
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final List<CartItem> cart = watch(userActionsProvider).cart;

        if (cart.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: Card(
              color: kCreamLight,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 100.h,
                  child: Center(
                    child: Text("Nothing here yet...",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
              ),
            ),
          );
        }

        final List<Widget> cartItemsList = [];
        for (int i = 0; i < cart.length; i++) {
          final CartItem cartItem = cart[i];
          final Future<dz.Either<ServerFailure, Item>> futureItem =
              watch(itemsRepositoryProvider).getItem(cartItem.itemId);
          cartItemsList.add(
            FutureBuilder(
              future: futureItem,
              builder: (BuildContext context,
                  AsyncSnapshot<dz.Either<ServerFailure, Item>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.fold(
                    (failure) => const Center(
                      child: Text('Server Problem'),
                    ),
                    (item) {
                      return CartItemCard(item, cartItem);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          );
        }
        return Column(
          children: cartItemsList,
        );
      },
    );
  }
}

class CartItemCard extends StatefulWidget {
  final Item item;
  final CartItem cartItem;

  const CartItemCard(this.item, this.cartItem);

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 7.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: SizedBox(
                width: 100.w,
                height: 27.h,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image.asset(
                      'assets/images/meat.png',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            kOrange,
                            kOrangeLight.withOpacity(0.5),
                            Colors.grey.withOpacity(0.0)
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    Dismissible(
                      key: ValueKey(widget.cartItem.itemId),
                      background: Container(
                        color: Colors.blue.withOpacity(0.7),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: const <Widget>[
                              SizedBox(width: 20),
                              Icon(Icons.edit, color: Colors.white),
                              Text(" Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red.withOpacity(0.7),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              Text(
                                " Delete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${widget.item.subCategory} ${widget.item.name}?"),
                                actions: <Widget>[
                                  ArgonButton(
                                    height: 9.w,
                                    width: 27.w,
                                    color: kOrange,
                                    borderRadius: 5.w,
                                    loader: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const SpinKitRotatingCircle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: (startLoading, stopLoading,
                                        btnState) async {
                                      if (btnState == ButtonState.Idle) {
                                        startLoading();
                                        await context.router.pop();
                                        stopLoading();
                                      }
                                    },
                                    child: Text(
                                      'CANCEL',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                  ArgonButton(
                                    height: 9.w,
                                    width: 27.w,
                                    color: kOrange,
                                    borderRadius: 5.w,
                                    loader: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const SpinKitRotatingCircle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: (startLoading, stopLoading,
                                        btnState) async {
                                      if (btnState == ButtonState.Idle) {
                                        startLoading();
                                        watch(userActionsProvider)
                                            .cart
                                            .removeWhere((_item) =>
                                                _item.itemId ==
                                                widget.cartItem.itemId);
                                        final List<CartItem> _cart =
                                            watch(userActionsProvider).cart;

                                        final cartRunner =
                                            await watch(userActionsProvider)
                                                .updateCart(_cart);
                                        cartRunner.fold(
                                          (failure) {
                                            watch(crashlyticsProvider).log(
                                                failure.messsage.toString());
                                            showTopSnackBar(
                                              context,
                                              const CustomSnackBar.error(
                                                message:
                                                    "We're unable to update the cart, please try again later",
                                              ),
                                            );
                                          },
                                          (_) {
                                            showTopSnackBar(
                                              context,
                                              const CustomSnackBar.success(
                                                message:
                                                    "Cart was updated successfully !",
                                              ),
                                            );
                                            context.router
                                                .replace(const CartRoute());
                                          },
                                        ); // Navigator.of(context).pop();
                                        await context.router.pop();

                                        stopLoading();
                                      }
                                    },
                                    child: Text(
                                      'DELETE',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          watch(cartItemProvider).cartItem = widget.cartItem;
                          watch(cartItemProvider).item = widget.item;
                          await context.router.navigate(const ItemRoute());
                        }
                      },
                      child: _SummaryContent(
                          item: widget.item, cartItem: widget.cartItem),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({
    Key? key,
    required this.item,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.subCategory}: ${item.name}',
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.fade,
                      ),
                      if (item.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 7.00),
                          child: Text(
                            item.description!,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      SizedBox(height: 2.h),
                      Text(
                        "${cartItem.quantity.toString()} kg",
                        style: Theme.of(context)
                            .textTheme
                            .overline!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
                        text: cartItem.price.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (cartItem.sizeTag != null && cartItem.sizeTag!.isNotEmpty)
              DisplayChip([cartItem.sizeTag!]),
            if (cartItem.preferenceTags != null &&
                cartItem.preferenceTags!.isNotEmpty)
              DisplayChip(cartItem.preferenceTags!.toList()),
            if (cartItem.guidelines != null && cartItem.guidelines!.isNotEmpty)
              Container(
                color: kCreamLight.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cartItem.guidelines!,
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
