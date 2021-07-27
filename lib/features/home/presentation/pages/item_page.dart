import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../main_common.dart';
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
              if (watch(cartItemProvider).item!.sizes!.isNotEmpty)
                const _SizesWidget(),
              if (watch(cartItemProvider).item!.preferredPieces!.isNotEmpty)
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
    final Item _item = watch(cartItemProvider).item!;
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
    final Item _item = watch(cartItemProvider).item!;
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
        container.read(cartItemProvider).quantity.toStringAsFixed(2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.text =
        container.read(cartItemProvider).quantity.toStringAsFixed(2);
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1.h),
          Text(
            "Quantity",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  watch(cartItemProvider).decrementQuantity();
                  _controller.value = TextEditingValue(
                    text: watch(cartItemProvider).quantity.toStringAsFixed(2),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.remove_rounded),
              ),
              SizedBox(
                width: 36.w,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    // suffix: Text("kg"),
                    suffixText: 'kg',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  validator: (value) {
                    if (value != null && double.tryParse(value) == null) {
                      return 'Enter a proper numeric value';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    try {
                      watch(cartItemProvider).quantity = double.parse(value);
                    } catch (exception, stack) {
                      watch(cartItemProvider).quantity = 0.0;
                      Logger.root
                          .severe('Unable to edit quantity', exception, stack);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  watch(cartItemProvider).incrementQuantity();
                  _controller.value = TextEditingValue(
                    text: watch(cartItemProvider).quantity.toStringAsFixed(2),
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
              watch(cartItemProvider)
                  .incrementQuantity(_quantityAdditives[selectedChip]);
              _controller.value = TextEditingValue(
                text: watch(cartItemProvider).quantity.toStringAsFixed(2),
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
        watch(cartItemProvider).item!.sizes!.split(',').toList();
    return Column(
      children: [
        SizedBox(height: 1.h),
        Text(
          'Sizes',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SelectChip(
          _itemSizes,
          onSelectionChanged: (selectedChip) =>
              watch(cartItemProvider).sizeTag = selectedChip,
          selectedTag: watch(cartItemProvider).sizeTag,
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
        watch(cartItemProvider).item!.preferredPieces!.split(',').toSet();
    return Column(
      children: [
        SizedBox(height: 1.h),
        Text(
          'Preferred Pieces',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        MultiSelectChip(
          _itemPreferences,
          onSelectionChanged: (selectedChips) =>
              watch(cartItemProvider).preferenceTags = selectedChips,
          selectedTags: watch(cartItemProvider).preferenceTags,
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
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h, left: 9.w, right: 9.w),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            initialValue: watch(cartItemProvider).guidelines,
            onChanged: (value) => watch(cartItemProvider).guidelines = value,
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
                text: watch(cartItemProvider).price.toStringAsFixed(2),
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
          final CartItem _cartItem = watch(cartItemProvider).cartItem;
          final List<CartItem> _cart = watch(userActionsProvider).cart;
          if (watch(cartItemProvider).cartItemSet) {
            _cart
                .removeWhere((cartItem) => cartItem.itemId == _cartItem.itemId);
            watch(cartItemProvider).cartItemSet = false;
          }
          _cart.add(_cartItem);
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
