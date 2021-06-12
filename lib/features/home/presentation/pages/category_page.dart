import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../data/models/item.dart';
import '../provider/items_provider.dart';

class CategoryListView extends StatelessWidget {
  final String category;
  const CategoryListView({required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final Future<dz.Either<ServerFailure, List<Item>>> futureItems =
            watch(itemsProvider).getItems();
        return FutureBuilder<dz.Either<ServerFailure, List<Item>>>(
            future: futureItems,
            builder: (BuildContext context,
                AsyncSnapshot<dz.Either<ServerFailure, List<Item>>>
                    snapshot) {
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
                            style: const TextStyle(fontSize: 16.00),
                          ),
                        ),
                      ),
                      for (Item item in items
                          .where((item) => item.subCategory == itemSubCategory))
                        ListTile(
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: (item.description!.isNotEmpty)
                              ? Text(
                                  item.description!,
                                  style: const TextStyle(fontSize: 12),
                                )
                              : null,
                          enabled: item.availability,
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.3),
                                    blurRadius: 10)
                              ],
                              border: Border.all(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/meat.png'),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(50, 50)),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                const Text(
                                  "500gm",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                if (item.discountedPrice!.isNotEmpty) Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$${item.discountedPrice!}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "\$${item.price}",
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 10.00),
                                          )
                                        ],
                                      ) else Text(
                                        "\$${item.price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                              ],
                            ),
                          ),
                          onTap: () async {
                            return context.router.navigate(ItemRoute(
                                itemJson: json.encode(item.toJson())));
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
                });
              } else {
                _widget = const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return _widget;
            });
      },
    );
  }
}

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
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: () => AutoRouter.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Hero(
                          tag: widget.category!,
                          child: SvgPicture.asset(
                              'assets/vectors/${widget.category}.svg',
                              semanticsLabel:
                                  categories[widget.category]!["name"]
                                      as String),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            CategoryListView(category: widget.category!),
          ],
        ),
      ),
    );
  }
}
