import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/router.gr.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item.dart';
import '../provider/items_provider.dart';

class CategoryListView extends StatelessWidget {
  final String category;
  CategoryListView({required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        Future<dz.Either<ServerFailure, List<ItemModel>>> futureItems =
            watch(itemsProvider).getItems();
        return FutureBuilder<dz.Either<ServerFailure, List<ItemModel>>>(
            future: futureItems,
            builder: (BuildContext context,
                AsyncSnapshot<dz.Either<ServerFailure, List<ItemModel>>>
                    snapshot) {
              late Widget _widget;
              if (snapshot.hasData) {
                _widget = snapshot.data!.fold(
                    (failure) => Center(child: const Text('Server Problem')),
                    (items) {
                  // _function to displayItems
                  List<Widget> _displayItems(String item_sub_category) {
                    return [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.00),
                          child: Text(
                            item_sub_category.toUpperCase(),
                            style: TextStyle(fontSize: 16.00),
                          ),
                        ),
                      ),
                      for (ItemModel item in items.where(
                          (item) => item.sub_category == item_sub_category))
                        ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: (item.description!.isNotEmpty)
                              ? Text(
                                  item.description!,
                                  style: TextStyle(fontSize: 12),
                                )
                              : null,
                          enabled: item.availability,
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.3),
                                    offset: Offset(0, 0),
                                    blurRadius: 10)
                              ],
                              border: Border.all(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                width: 1,
                              ),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/meat.png'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(50, 50)),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Text(
                                  "500gm",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                (item.discounted_price!.isNotEmpty)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$" + item.discounted_price!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "\$" + item.price,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 10.00),
                                          )
                                        ],
                                      )
                                    : Text(
                                        "\$" + item.price,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                              ],
                            ),
                          ),
                          onTap: () async {
                            return await context.router.navigate(ItemRoute(
                                itemJson: json.encode(item.toJson())));
                          },
                        ),
                    ];
                  }

                  return Expanded(
                    child: ListView(
                      children: [
                        for (String item_sub_category
                            in categories[category]!["sub_categories"])
                          ..._displayItems(item_sub_category)
                      ],
                    ),
                  );
                });
              } else {
                _widget = Center(
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
                  icon: Icon(Icons.arrow_back_rounded),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Hero(
                          tag: widget.category!,
                          child: SvgPicture.asset(
                              'assets/vectors/${widget.category}.svg',
                              semanticsLabel:
                                  categories[widget.category]!["name"]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            CategoryListView(category: widget.category!),
          ],
        ),
      ),
    );
  }
}
