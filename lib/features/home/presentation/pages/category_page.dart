import 'package:auto_route/auto_route.dart';
import 'package:cutso/core/providers/user_actions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../widgets/category_items_list_widget.dart';

class CategoryPage extends StatefulWidget {
  final String? category;

  const CategoryPage({@PathParam('category') this.category, Key? key})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: Consumer(
          builder: (context, watch, child) => Column(
            children: [
              _CategoryPageHeader(widget: widget),
              const Divider(),
              CategoryItemsListView(category: widget.category!),
              if (watch(userActionsProvider).cart.orderItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 12.0, left: 12.0, right: 12.0),
                  child: SizedBox(
                    height: 9.h,
                    child: InkWell(
                      onTap: () => context.router.navigate(const CartRoute()),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kOrange,
                            borderRadius: BorderRadius.circular(9.0),
                            boxShadow: const [BoxShadow()]),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${watch(userActionsProvider).cart.orderItems.length.toString()} Items",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "\u{20B9} ",
                                          style: GoogleFonts.roboto()
                                              .copyWith(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: watch(userActionsProvider)
                                              .getCartValue()
                                              .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "View Cart",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  const Icon(
                                      Icons.keyboard_arrow_right_rounded),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryPageHeader extends StatelessWidget {
  const _CategoryPageHeader({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CategoryPage widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        Center(
          child: Column(
            children: [
              Container(
                height: 27.w,
                width: 27.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Hero(
                  tag: widget.category!,
                  child:
                      SvgPicture.asset('assets/vectors/${widget.category}.svg'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
