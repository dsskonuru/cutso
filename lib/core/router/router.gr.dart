// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../features/home/presentation/pages/home_page.dart' as _i4;
import '../../features/home/presentation/pages/products/bd_page.dart' as _i8;
import '../../features/home/presentation/pages/products/chicken_page.dart'
    as _i5;
import '../../features/home/presentation/pages/products/ens_page.dart' as _i9;
import '../../features/home/presentation/pages/products/mutton_page.dart'
    as _i6;
import '../../features/home/presentation/pages/products/rtc_page.dart' as _i10;
import '../../features/home/presentation/pages/products/seafood_page.dart'
    as _i7;
import '../../features/login/presentation/pages/sign_in.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoginRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.LoginWrapperPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.HomePage();
        }),
    ChickenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.ChickenPage();
        }),
    MuttonRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.MuttonPage();
        }),
    SeaFoodRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.SeaFoodPage();
        }),
    BestDealsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.BestDealsPage();
        }),
    EggsNSidesRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.EggsNSidesPage();
        }),
    ReadyToCookRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.ReadyToCookPage();
        }),
    MobileFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MobileFormPage();
        }),
    OtpFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.OtpFormPage();
        }),
    RegistrationFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.RegistrationFormPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LoginRouter.name, path: '/', children: [
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

class LoginRouter extends _i1.PageRouteInfo {
  const LoginRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'LoginRouter';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
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
