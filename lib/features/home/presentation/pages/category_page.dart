import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/theme_data.dart';
import '../../data/models/item.dart';
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
        child: Column(
          children: [
            Stack(
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
            CategoryItemsListView(category: widget.category!),
          ],
        ),
      ),
    );
  }
}
