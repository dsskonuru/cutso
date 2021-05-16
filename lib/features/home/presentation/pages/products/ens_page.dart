import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EggsNSidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ElevatedButton(
        onPressed: () => AutoRouter.of(context).pop(),
        child: Text('Go Back'),
      ),
    );
  }
}