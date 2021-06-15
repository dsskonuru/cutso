import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/providers/firebase_provider.dart';
import 'core/router/router.gr.dart';
import 'core/theme/theme_data.dart';

final container = ProviderContainer(observers: [Logger()]);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = container.read(crashlyticsProvider).recordFlutterError;
  runApp(CutsoApp());
}

class CutsoApp extends StatefulWidget {
  @override
  State<CutsoApp> createState() => _CutsoAppState();
}

class _CutsoAppState extends State<CutsoApp> {
  final _appRouter = AppRouter();

  @override
  void dispose() {
    super.dispose();
    // disposing the globally self managed container.
    container.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp.router(
            theme: themeData(context),
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    container.read(crashlyticsProvider).log(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''',
    );
  }
}
