import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ReadyToCookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: ElevatedButton(
        onPressed: () => AutoRouter.of(context).pop(),
        child: Text('Go Back'),
      ),
    );
  }
}