import 'package:auto_route/auto_route.dart';
import 'package:cutso/core/providers/firebase_provider.dart';
import 'package:cutso/features/home/presentation/provider/order_item_form_provider.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../data/models/item.dart';
import '../../data/sources/items_repository.dart';

class CategoryItemsListView extends ConsumerWidget {
  const CategoryItemsListView({required this.category});

  final String category;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return FutureBuilder<dz.Either<ServerFailure, List<Item>>>(
      future: watch(itemsRepositoryProvider)
          .getItemsList(categories[category]!["name"].toString()),
      builder: (BuildContext context,
          AsyncSnapshot<dz.Either<ServerFailure, List<Item>>> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.fold(
            (failure) => const Center(child: Text('Server Problem')),
            (items) {
              if (items.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Text("Coming soon!",
                          style: Theme.of(context).textTheme.headline6)),
                );
              } else {
                return _ItemsList(category: category, items: items);
              }
            },
          );
        } else if (snapshot.hasError) {
          watch(crashlyticsProvider).log(snapshot.error.toString());
          return const Center(child: Text('Something went wrong'));
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class _ItemsList extends ConsumerWidget {
  const _ItemsList({
    Key? key,
    required this.category,
    required this.items,
  }) : super(key: key);

  final String category;
  final List<Item> items;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      child: ListView(
        children: [
          if (categories[category]!["sub_categories"] != [])
            for (String itemSubCategory
                in categories[category]!["sub_categories"])
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.00),
                      child: Text(
                        itemSubCategory.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  for (Item item in items
                      .where((item) => item.subCategory == itemSubCategory))
                    ListTile(
                      title: Text(
                        item.name,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      subtitle: (item.description!.isNotEmpty)
                          ? Text(
                              item.description!,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          : null,
                      enabled: item.availability,
                      leading: const _LeadingCircularImageWidget(),
                      trailing: _TrailingPriceWidget(item: item),
                      onTap: () async {
                        watch(orderItemProvider).item = item;
                        return context.router.navigate(const ItemRoute());
                      },
                    ),
                ],
              )
          else
            const Text("No sub categories were found!")
        ],
      ),
    );
  }
}

class _TrailingPriceWidget extends StatelessWidget {
  const _TrailingPriceWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "500gm",
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 5.w),
          if (item.discountedPrice!.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: "\u{20B9} ",
                          style: GoogleFonts.roboto()
                              .copyWith(color: Colors.black)),
                      TextSpan(
                        text: item.discountedPrice,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "\u{20B9} ",
                        style: GoogleFonts.roboto().copyWith(
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: item.price,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            )
          else
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "\u{20B9} ",
                      style:
                          GoogleFonts.roboto().copyWith(color: Colors.black)),
                  TextSpan(
                    text: item.price,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LeadingCircularImageWidget extends StatelessWidget {
  const _LeadingCircularImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 10)],
        border: Border.all(color: kOrange),
        image: const DecorationImage(
            image: AssetImage('assets/images/meat.png'), fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
      ),
    );
  }
}
