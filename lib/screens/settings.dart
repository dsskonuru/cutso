// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Settings'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // context.tabsRouter
              //   ..setActiveIndex(0)
              //   ..innerRouterOf<StackRouter>(BooksTab.name)?.push(BookDetailsRoute(id: 4));
              debugPrint("LOL");
            },
            child: Text('Navigate to Book/4'),
          )
        ],
      ),
    );
  }
}
