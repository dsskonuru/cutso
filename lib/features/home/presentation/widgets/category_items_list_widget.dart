import 'dart:convert';

import 'package:auto_route/auto_route.dart';
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
  final String category;
  const CategoryItemsListView({required this.category});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Future<dz.Either<ServerFailure, List<Item>>> futureItems =
        watch(itemsRepositoryProvider).getItemsList();

    return FutureBuilder<dz.Either<ServerFailure, List<Item>>>(
      future: futureItems,
      builder: (BuildContext context,
          AsyncSnapshot<dz.Either<ServerFailure, List<Item>>> snapshot) {
        late Widget _widget;
        if (snapshot.hasData) {
          _widget = snapshot.data!.fold(
            (failure) => const Center(child: Text('Server Problem')),
            (items) {
              // _function to displayItems
              List<Widget> _displayItems(String itemSubCategory) {
                return [
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
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      subtitle: (item.description!.isNotEmpty)
                          ? Text(
                              item.description!,
                              style: Theme.of(context).textTheme.overline,
                            )
                          : null,
                      enabled: item.availability,
                      leading: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: Colors.black38, blurRadius: 10)
                          ],
                          border: Border.all(color: kOrange),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/meat.png'),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.elliptical(50, 50)),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 30.w,
                        child: Row(
                          children: [
                            Text(
                              "500gm",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(fontSize: 7.sp),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
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
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.price,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 10.sp),
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
                                        style: GoogleFonts.roboto()
                                            .copyWith(color: Colors.black)),
                                    TextSpan(
                                      text: item.price,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        return context.router.navigate(
                            ItemRoute(itemJson: json.encode(item.toJson())));
                      },
                    ),
                ];
              }

              return Expanded(
                child: ListView(
                  children: [
                    for (String itemSubCategory
                        in categories[category]!["sub_categories"])
                      ..._displayItems(itemSubCategory)
                  ],
                ),
              );
            },
          );
        } else {
          _widget = const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return _widget;
      },
    );
  }
}
