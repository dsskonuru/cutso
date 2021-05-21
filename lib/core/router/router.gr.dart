// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../features/home/presentation/pages/category_page.dart' as _i5;
import '../../features/home/presentation/pages/home_page.dart' as _i4;
import '../../features/login/presentation/pages/mobile_form_page.dart' as _i6;
import '../../features/login/presentation/pages/otp_form_page.dart' as _i7;
import '../../features/login/presentation/pages/registration_form_page.dart'
    as _i8;
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
    CategoryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<CategoryRouteArgs>(
              orElse: () => CategoryRouteArgs(
                  category: pathParams.optString('category')));
          return _i5.CategoryPage(category: args.category, key: args.key);
        }),
    MobileFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.MobileFormPage();
        }),
    OtpFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.OtpFormPage();
        }),
    RegistrationFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.RegistrationFormPage();
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
        _i1.RouteConfig(CategoryRoute.name, path: '/category'),
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

class CategoryRoute extends _i1.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({String? category, _i2.Key? key})
      : super(name,
            path: '/category',
            args: CategoryRouteArgs(category: category, key: key));

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.category, this.key});

  final String? category;

  final _i2.Key? key;
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
