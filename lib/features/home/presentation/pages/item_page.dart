import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../main.dart';
import '../../../login/data/models/user.dart';
import '../../data/models/item.dart';
import '../provider/order_item_form_provider.dart';
import '../widgets/chips_widget.dart';

const Map<String, double> _quantityAdditives = {
  '+100g': 0.1,
  '+250g': 0.25,
  '+1kg': 1.00,
  '+2kg': 2.00,
  '+5kg': 5.00,
};

class ItemPage extends ConsumerWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _ItemPageHeader(),
              const Divider(),
              const _ItemTitle(),
              const Divider(),
              const _QuantityWidget(),
              const Divider(),
              if (watch(orderItemProvider).item!.sizes!.isNotEmpty)
                const _SizesWidget(),
              if (watch(orderItemProvider).item!.preferredPieces!.isNotEmpty)
                const _PreferredPiecesWidget(),
              const _GuidelinesWidget(),
              const Divider(),
              const _ItemValueWidget(),
              const Divider(),
              const _AddToCartButton(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemPageHeader extends ConsumerWidget {
  const _ItemPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Item _item = watch(orderItemProvider).item!;
    return Stack(
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
              tag: getCategoryFromId(_item.id),
              child: SvgPicture.asset(
                  'assets/vectors/${getCategoryFromId(_item.id)}.svg'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemTitle extends ConsumerWidget {
  const _ItemTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Item _item = watch(orderItemProvider).item!;
    return SizedBox(
      width: 100.w,
      height: 16.h,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.asset('assets/images/meat.png', fit: BoxFit.cover),
          ClipRRect(
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
    );
  }
}

class _QuantityWidget extends StatefulWidget {
  const _QuantityWidget({Key? key}) : super(key: key);

  @override
  State<_QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<_QuantityWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        container.read(orderItemProvider).quantity.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) => Column(
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
                onPressed: () {
                  watch(orderItemProvider).decrementQuantity();
                  _controller.value = TextEditingValue(
                    text: watch(orderItemProvider).quantity.toStringAsFixed(2),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.remove_rounded),
              ),
              SizedBox(
                width: 18.w,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffix: Text("kg"),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: _controller,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      watch(orderItemProvider).quantity = double.parse(value);
                    } else {
                      watch(orderItemProvider).quantity = 0.0;
                    }
                  },
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              IconButton(
                onPressed: () {
                  watch(orderItemProvider).incrementQuantity();
                  _controller.value = TextEditingValue(
                    text: watch(orderItemProvider).quantity.toStringAsFixed(2),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          SelectChip(
            _quantityAdditives.keys.toList(),
            onSelectionChanged: (selectedChip) {
              watch(orderItemProvider)
                  .incrementQuantity(_quantityAdditives[selectedChip]);
              _controller.value = TextEditingValue(
                text: watch(orderItemProvider).quantity.toStringAsFixed(2),
              );
              setState(() {});
            },
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }
}

class _SizesWidget extends ConsumerWidget {
  const _SizesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<String> _itemSizes =
        watch(orderItemProvider).item!.sizes!.split(',').toList();
    return Column(
      children: [
        SizedBox(height: 1.h),
        Text(
          'Sizes',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SelectChip(
          _itemSizes,
          onSelectionChanged: (selectedChip) =>
              watch(orderItemProvider).sizeTag = selectedChip,
          selectedTag: watch(orderItemProvider).sizeTag,
        ),
        SizedBox(height: 1.h),
        const Divider(),
      ],
    );
  }
}

class _PreferredPiecesWidget extends ConsumerWidget {
  const _PreferredPiecesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Set<String> _itemPreferences =
        watch(orderItemProvider).item!.preferredPieces!.split(',').toSet();
    return Column(
      children: [
        SizedBox(height: 1.h),
        Text(
          'Preferred Pieces',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        MultiSelectChip(
          _itemPreferences,
          onSelectionChanged: (selectedChips) =>
              watch(orderItemProvider).preferenceTags = selectedChips,
          selectedTags: watch(orderItemProvider).preferenceTags,
        ),
        SizedBox(height: 1.h),
        const Divider(),
      ],
    );
  }
}

class _GuidelinesWidget extends ConsumerWidget {
  const _GuidelinesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        Text(
          'Guidelines',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h, left: 9.w, right: 9.w),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            initialValue: watch(orderItemProvider).guidelines,
            onChanged: (value) => watch(orderItemProvider).guidelines = value,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}

class _ItemValueWidget extends ConsumerWidget {
  const _ItemValueWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "\u{20B9} ",
                style: GoogleFonts.roboto().copyWith(color: Colors.black),
              ),
              TextSpan(
                text: watch(orderItemProvider).price.toStringAsFixed(2),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}

class _AddToCartButton extends ConsumerWidget {
  const _AddToCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ArgonButton(
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
          final OrderItem _orderItem = watch(orderItemProvider).orderItem;
          final Cart _cart = watch(userActionsProvider).cart;
          if (watch(orderItemProvider).orderItemSet) {
            _cart.orderItems.removeWhere(
                (orderItem) => orderItem.itemId == _orderItem.itemId);
            watch(orderItemProvider).orderItemSet = false;
          }
          _cart.add(_orderItem);
          final cartRunner = await watch(userActionsProvider).updateCart(_cart);
          cartRunner.fold(
            (failure) {
              watch(crashlyticsProvider).log(failure.messsage.toString());
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
          context.router.popAndPush(const CartRoute());
        }
      },
      child: Text(
        '+ CART',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
