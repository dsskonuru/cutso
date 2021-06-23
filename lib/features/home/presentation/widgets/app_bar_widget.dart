import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';

class CutsoAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(180);

  @override
  Widget build(BuildContext context) {
    final double _statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: 16.h,
      padding: EdgeInsets.only(
        top: _statusbarHeight,
        right: 7.w,
        left: 7.w,
      ),
      decoration: const BoxDecoration(
        color: kCreamDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: kOrangeDark,
            onPressed: () => context.router.root.navigate(const ProfileRoute()),
            icon: const Icon(Icons.account_circle_rounded),
            iconSize: 9.w,
          ),
          Image(
            height: 7.h,
            image: const AssetImage('assets/images/cutso-text.png'),
          ),
          IconButton(
            color: kOrangeDark,
            onPressed: () => context.router.root.navigate(const CartRoute()),
            icon: const Icon(Icons.shopping_cart_rounded),
            iconSize: 7.w,
          ),
        ],
      ),
    );
  }
}
