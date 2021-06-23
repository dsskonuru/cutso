import 'dart:convert';
import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../login/data/models/user.dart';
import '../../data/models/item.dart';
import '../provider/order_item_form_provider.dart';
import '../widgets/chips_widget.dart';

class ItemPage extends ConsumerWidget {
  final String itemJson;
  final String? orderItemJson;

  const ItemPage({
    @PathParam('itemJson') required this.itemJson,
    @PathParam('orderItemJson') this.orderItemJson,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Item _item =
        Item.fromJson(json.decode(itemJson) as Map<String, dynamic>);
    final List<String> _itemSizes = _item.sizes!.split(',').toList();
    final List<String> _itemPreferences =
        _item.preferredPieces!.split(',').toList();

    if (orderItemJson != null) {
      final OrderItem _orderItem = OrderItem.fromJson(
          json.decode(orderItemJson!) as Map<String, dynamic>);
      context.read(orderItemProvider).setOrderItem(_orderItem);
    }

    final OrderItemNotifier orderItemNotifier = watch(orderItemProvider);
    // final Cart cart = watch(userActionsProvider).cart;

    return Scaffold(
      backgroundColor: kCream,
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
                    child: Container(
                      height: 27.w,
                      width: 27.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: _item.id,
                        child: SvgPicture.asset(
                            'assets/vectors/${getCategoryFromId(_item.id)}.svg',
                            semanticsLabel: getCategoryFromId(_item.id)),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                width: 100.w,
                height: 16.h,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image.asset('assets/images/meat.png', fit: BoxFit.cover),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _item.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                _item.subCategory.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Column(
                children: [
                  SizedBox(height: 1.h),
                  Text(
                    "Quantity",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => orderItemNotifier.decrementQuantity(),
                        icon: const Icon(Icons.remove_rounded),
                      ),
                      Text(
                        '${orderItemNotifier.quantity.toStringAsFixed(2)} kg',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      IconButton(
                        onPressed: () => orderItemNotifier.incrementQuantity(),
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                  SelectChip(
                    _quantityAdditives.keys.toList(),
                    onSelection: (selectedChip) => orderItemNotifier
                        .incrementQuantity(_quantityAdditives[selectedChip]),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
              const Divider(),
              SizedBox(height: 1.h),
              if (_itemSizes.first.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Sizes',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    MultiSelectChip(
                      _itemSizes,
                      onSelectionChanged: (selectedChips) =>
                          orderItemNotifier.addSizeTags(selectedChips),
                    ),
                    SizedBox(height: 1.h),
                    const Divider(),
                    SizedBox(height: 1.h),
                  ],
                ),
              if (_itemPreferences.first.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Preferred Pieces',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    MultiSelectChip(
                      _itemPreferences,
                      onSelectionChanged: (selectedChips) =>
                          orderItemNotifier.addPreferenceTags(selectedChips),
                    ),
                    SizedBox(height: 1.h),
                    const Divider(),
                    SizedBox(height: 1.h),
                  ],
                ),
              Column(
                children: [
                  Text(
                    'Guidelines',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h, left: 9.w, right: 9.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      initialValue: orderItemNotifier.guidelines,
                      onChanged: (value) =>
                          orderItemNotifier.setGuidelines(value),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  const Divider(),
                  SizedBox(height: 1.h),
                ],
              ),
              // Text(watch(orderItemProvider).getOrderItemPrice().toString()),
              // SizedBox(height: 1.h),
              // const Divider(),
              ArgonButton(
                height: 9.w,
                width: 36.w,
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
                    final OrderItem _orderItem = OrderItem(
                      itemId: _item.id,
                      quantity: orderItemNotifier.quantity,
                      sizeTags: orderItemNotifier.sizeTags,
                      preferenceTags: orderItemNotifier.preferenceTags,
                      guidelines: orderItemNotifier.guidelines,
                      price: double.parse(_item.price) *
                          2 *
                          orderItemNotifier.quantity,
                    );
                    final cart = watch(userActionsProvider).cart;
                    if (orderItemJson != null) {
                      cart.orderItems.removeWhere(
                          (orderItem) => orderItem.itemId == _orderItem.itemId);
                    }
                    cart.add(_orderItem);
                    final cartRunner =
                        await watch(userActionsProvider).updateCart(cart);
                    cartRunner.fold(
                      (failure) {
                        watch(crashlyticsProvider)
                            .log(failure.messsage.toString());
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
                            message: "Cart was updated successfully !",
                          ),
                        );
                      },
                    );
                    stopLoading();
                  }
                },
                child: Text(
                  '+ CART',
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

const Map<String, double> _quantityAdditives = {
  '+100g': 0.1,
  '+250g': 0.25,
  '+1kg': 1.00,
  '+2kg': 2.00,
  '+5kg': 5.00,
};
