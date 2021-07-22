import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';

class CategoryTileWidget extends StatelessWidget {
  final String itemCategory;
  const CategoryTileWidget({required this.itemCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () =>
              context.router.push(CategoryRoute(category: itemCategory)),
          child: Center(
            child: Container(
              height: 30.w,
              width: 30.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kOrangeLight.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Hero(
                tag: itemCategory,
                child: SvgPicture.asset(
                  'assets/vectors/$itemCategory.svg',
                  semanticsLabel: itemCategory,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Center(
          child: Text(
            itemCategory.toUpperCase().split("-").join(" "),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }
}
