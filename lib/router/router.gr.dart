// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:cloud_firestore/cloud_firestore.dart' as _i12;
import 'package:flutter/material.dart' as _i11;

import '../screens/home/home_page.dart' as _i4;
import '../screens/products/bd_page.dart' as _i8;
import '../screens/products/chicken_page.dart' as _i5;
import '../screens/products/ens_page.dart' as _i9;
import '../screens/products/mutton_page.dart' as _i6;
import '../screens/products/rtc_page.dart' as _i10;
import '../screens/products/seafood_page.dart' as _i7;
import '../screens/sign_in/sign_in.dart' as _i3;
import '../services/petpooja_api_service.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MyApiRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.MyApiPage());
    },
    LoginRouter.name: (entry) {
      return _i1.MaterialPageX(
          entry: entry, child: const _i3.LoginWrapperPage());
    },
    HomeRoute.name: (entry) {
      var args =
          entry.routeData.argsAs<HomeRouteArgs>(orElse: () => HomeRouteArgs());
      return _i1.MaterialPageX(
          entry: entry,
          child: _i4.HomePage(key: args.key, userProfile: args.userProfile));
    },
    ChickenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i5.ChickenPage());
    },
    MuttonRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i6.MuttonPage());
    },
    SeaFoodRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i7.SeaFoodPage());
    },
    BestDealsRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i8.BestDealsPage());
    },
    EggsNSidesRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i9.EggsNSidesPage());
    },
    ReadyToCookRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i10.ReadyToCookPage());
    },
    MobileFormRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.MobileFormPage());
    },
    OtpFormRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.OtpFormPage());
    },
    RegistrationFormRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.RegistrationFormPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MyApiRoute.name, path: '/'),
        _i1.RouteConfig(LoginRouter.name, path: '/login', children: [
          _i1.RouteConfig('#redirect',
              path: '', redirectTo: '/', fullMatch: true),
          _i1.RouteConfig(MobileFormRoute.name, path: ''),
          _i1.RouteConfig(OtpFormRoute.name, path: 'otp'),
          _i1.RouteConfig(RegistrationFormRoute.name, path: 'registration')
        ]),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(ChickenRoute.name, path: '/chicken'),
        _i1.RouteConfig(MuttonRoute.name, path: '/mutton'),
        _i1.RouteConfig(SeaFoodRoute.name, path: '/sea-food'),
        _i1.RouteConfig(BestDealsRoute.name, path: '/bd'),
        _i1.RouteConfig(EggsNSidesRoute.name, path: '/ens'),
        _i1.RouteConfig(ReadyToCookRoute.name, path: '/rtc'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class MyApiRoute extends _i1.PageRouteInfo {
  const MyApiRoute() : super(name, path: '/');

  static const String name = 'MyApiRoute';
}

class LoginRouter extends _i1.PageRouteInfo {
  const LoginRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/login', initialChildren: children);

  static const String name = 'LoginRouter';
}

class HomeRoute extends _i1.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i11.Key? key, _i12.DocumentSnapshot? userProfile})
      : super(name,
            path: '/home',
            args: HomeRouteArgs(key: key, userProfile: userProfile));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.userProfile});

  final _i11.Key? key;

  final _i12.DocumentSnapshot? userProfile;
}

class ChickenRoute extends _i1.PageRouteInfo {
  const ChickenRoute() : super(name, path: '/chicken');

  static const String name = 'ChickenRoute';
}

class MuttonRoute extends _i1.PageRouteInfo {
  const MuttonRoute() : super(name, path: '/mutton');

  static const String name = 'MuttonRoute';
}

class SeaFoodRoute extends _i1.PageRouteInfo {
  const SeaFoodRoute() : super(name, path: '/sea-food');

  static const String name = 'SeaFoodRoute';
}

class BestDealsRoute extends _i1.PageRouteInfo {
  const BestDealsRoute() : super(name, path: '/bd');

  static const String name = 'BestDealsRoute';
}

class EggsNSidesRoute extends _i1.PageRouteInfo {
  const EggsNSidesRoute() : super(name, path: '/ens');

  static const String name = 'EggsNSidesRoute';
}

class ReadyToCookRoute extends _i1.PageRouteInfo {
  const ReadyToCookRoute() : super(name, path: '/rtc');

  static const String name = 'ReadyToCookRoute';
}

class MobileFormRoute extends _i1.PageRouteInfo {
  const MobileFormRoute() : super(name, path: '');

  static const String name = 'MobileFormRoute';
}

class OtpFormRoute extends _i1.PageRouteInfo {
  const OtpFormRoute() : super(name, path: 'otp');

  static const String name = 'OtpFormRoute';
}

class RegistrationFormRoute extends _i1.PageRouteInfo {
  const RegistrationFormRoute() : super(name, path: 'registration');

  static const String name = 'RegistrationFormRoute';
}
