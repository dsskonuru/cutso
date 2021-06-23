import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<Future<SharedPreferences>>(
    (ref) => SharedPreferences.getInstance());
