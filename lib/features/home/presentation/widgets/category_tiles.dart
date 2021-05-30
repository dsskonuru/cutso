import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/router/router.gr.dart';

class CategoryWidget extends StatelessWidget {
  final String item_category;
  CategoryWidget({required this.item_category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context)
              .push(CategoryRoute(category: item_category)),
          child: Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Hero(
                tag: item_category,
                child: SvgPicture.asset('assets/vectors/$item_category.svg',
                    semanticsLabel: item_category),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.00,
        ),
        Center(
          child: Text(item_category.toUpperCase().split("-").join(" ")),
        ),
      ],
    );
  }
}
