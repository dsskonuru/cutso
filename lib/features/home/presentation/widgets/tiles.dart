import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/router/router.gr.dart';

class ChickenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(ChickenRoute()),
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
                tag: 'chicken',
                child: SvgPicture.asset('assets/vectors/chicken.svg',
                    semanticsLabel: 'chicken'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Chicken'),
        ),
      ],
    );
  }
}

class MuttonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(MuttonRoute()),
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
                tag: 'mutton',
                child: SvgPicture.asset('assets/vectors/mutton.svg',
                    semanticsLabel: 'mutton'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Mutton'),
        )
      ],
    );
  }
}

class SeaFoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(SeaFoodRoute()),
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
                tag: 'sea-food',
                child: SvgPicture.asset('assets/vectors/fish.svg',
                    semanticsLabel: 'sea food'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Sea Food'),
        ),
      ],
    );
  }
}

class ReadyToCookWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(ReadyToCookRoute()),
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
                tag: 'ready-to-cook',
                child: SvgPicture.asset('assets/vectors/ready-to-cook.svg',
                    semanticsLabel: 'ready to cook'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Ready to Cook'),
        ),
      ],
    );
  }
}

class BestDealsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(BestDealsRoute()),
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
                tag: 'best-deals',
                child: SvgPicture.asset('assets/vectors/best-deals.svg',
                    semanticsLabel: 'best deals'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Best Deals'),
        ),
      ],
    );
  }
}

class EggsNSidesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context).push(EggsNSidesRoute()),
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
                tag: 'eggs-n-sides',
                child: SvgPicture.asset('assets/vectors/eggs-n-sides.svg',
                    semanticsLabel: 'eggs and sides'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text('Eggs and Sides'),
        ),
      ],
    );
  }
}
