import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config_reader.dart';
import 'core/providers/firebase_provider.dart';
import 'core/providers/shared_preferences_provider.dart';
import 'core/providers/user_actions_provider.dart';
import 'core/router/router.gr.dart';
import 'core/theme/theme_data.dart';
import 'environment.dart';
import 'features/login/data/models/user.dart';

final container = ProviderContainer(observers: [Logger()]);

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();

  String myEnv;
  switch (env) {
    case Environment.dev:
      myEnv = "This is dev env !";
      debugPrint(myEnv);
      break;
    case Environment.prod:
      myEnv = "This is prod env !";
      debugPrint(myEnv);
      break;
  }

  await Firebase.initializeApp();
  FlutterError.onError = container.read(crashlyticsProvider).recordFlutterError;
  await setupUser();

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

Future<void> setupUser() async {
  try {
    final SharedPreferences prefs =
        await container.read(sharedPreferencesProvider);
    // prefs.clear();
    final uid = prefs.getString("uid");
    if (uid != null) {
      await container.read(usersProvider).doc(uid).get().then(
        (DocumentSnapshot<User> userSnapshot) async {
          if (userSnapshot.exists) {
            container.read(crashlyticsProvider).log('User is signed in');
            container.read(userActionsProvider).user = userSnapshot.data();
          } else {
            container
                .read(crashlyticsProvider)
                .log('User requires registration');
            container.read(userActionsProvider).user = null;
          }
        },
      );
    }
  } catch (exception, stack) {
    debugPrint(exception.toString());
    container.read(crashlyticsProvider).recordError(exception, stack);
  }
}
