import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BestDealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: ElevatedButton(
        onPressed: () => AutoRouter.of(context).pop(),
        child: Text('Go Back'),
      ),
    );
  }
}