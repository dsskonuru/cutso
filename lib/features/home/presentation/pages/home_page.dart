import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/theme_data.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/category_tile_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: CutsoAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: GridView.count(
            crossAxisCount: 2,
            // crossAxisSpacing: 5,
            // mainAxisSpacing: 5,
            children: const [
              CategoryTileWidget(itemCategory: 'bird'),
              CategoryTileWidget(itemCategory: 'mutton'),
              CategoryTileWidget(itemCategory: 'sea-food'),
              CategoryTileWidget(itemCategory: 'eggs-n-sides'),
              CategoryTileWidget(itemCategory: 'ready-to-cook'),
              CategoryTileWidget(itemCategory: 'best-deals'),
            ],
          ),
        ),
      ),
    );
  }
}
