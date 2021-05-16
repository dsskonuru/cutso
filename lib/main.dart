import 'package:chopper/chopper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'features/home/domain/repositories/petpooja_api_service.dart';
import 'core/router/router.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      debugPrint('$_error');
    }
    if (!_initialized) {
      return Loading();
    }
    return CutsoApp();
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CutsoApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      PostApiService apiService = watch(apiProvider);
      return FutureBuilder<Response>(
          future: apiService.menuPost(menuBody),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                );
              }
              context.read(postMenuProvider).setPostMenu(snapshot.data!.body);
              return MaterialApp.router(
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
              );
            }
            return Center(child: CircularProgressIndicator());
          });
    });
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
