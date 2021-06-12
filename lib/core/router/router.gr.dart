// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../features/cart/presentation/pages/cart_page.dart' as _i11;
import '../../features/home/presentation/pages/category_page.dart' as _i9;
import '../../features/home/presentation/pages/home_page.dart' as _i8;
import '../../features/home/presentation/pages/item_page.dart' as _i10;
import '../../features/login/presentation/pages/address_form_page.dart' as _i7;
import '../../features/login/presentation/pages/mobile_form_page.dart' as _i4;
import '../../features/login/presentation/pages/onboarding_page.dart' as _i3;
import '../../features/login/presentation/pages/otp_form_page.dart' as _i5;
import '../../features/login/presentation/pages/registration_form_page.dart'
    as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.OnboardingPage();
        }),
    MobileFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MobileFormRouteArgs>(
              orElse: () => const MobileFormRouteArgs());
          return _i4.MobileFormPage(key: args.key);
        }),
    OtpFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.OtpFormPage();
        }),
    RegistrationFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<RegistrationFormRouteArgs>(
              orElse: () => RegistrationFormRouteArgs(
                  asUpdate: pathParams.getBool('asUpdate')));
          return _i6.RegistrationFormPage(asUpdate: args.asUpdate);
        }),
    AddressFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<AddressFormRouteArgs>(
              orElse: () => AddressFormRouteArgs(
                  asUpdate: pathParams.getBool('asUpdate')));
          return _i7.AddressFormPage(asUpdate: args.asUpdate);
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i8.HomePage();
        }),
    CategoryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<CategoryRouteArgs>(
              orElse: () => CategoryRouteArgs(
                  category: pathParams.optString('category')));
          return _i9.CategoryPage(category: args.category, key: args.key);
        }),
    ItemRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ItemRouteArgs>(
              orElse: () => ItemRouteArgs(
                  itemJson: pathParams.getString('itemJson'),
                  orderItemJson: pathParams.optString('orderItemJson')));
          return _i10.ItemPage(
              itemJson: args.itemJson,
              orderItemJson: args.orderItemJson,
              key: args.key);
        }),
    CartRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.CartPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(OnboardingRoute.name, path: '/'),
        _i1.RouteConfig(MobileFormRoute.name, path: '/mobileForm'),
        _i1.RouteConfig(OtpFormRoute.name, path: '/otpForm'),
        _i1.RouteConfig(RegistrationFormRoute.name, path: '/registrationForm'),
        _i1.RouteConfig(AddressFormRoute.name, path: '/addressForm'),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(CategoryRoute.name, path: '/category'),
        _i1.RouteConfig(ItemRoute.name, path: '/item'),
        _i1.RouteConfig(CartRoute.name, path: '/cart'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class OnboardingRoute extends _i1.PageRouteInfo {
  const OnboardingRoute() : super(name, path: '/');

  static const String name = 'OnboardingRoute';
}

class MobileFormRoute extends _i1.PageRouteInfo<MobileFormRouteArgs> {
  MobileFormRoute({_i2.Key? key})
      : super(name, path: '/mobileForm', args: MobileFormRouteArgs(key: key));

  static const String name = 'MobileFormRoute';
}

class MobileFormRouteArgs {
  const MobileFormRouteArgs({this.key});

  final _i2.Key? key;
}

class OtpFormRoute extends _i1.PageRouteInfo {
  const OtpFormRoute() : super(name, path: '/otpForm');

  static const String name = 'OtpFormRoute';
}

class RegistrationFormRoute
    extends _i1.PageRouteInfo<RegistrationFormRouteArgs> {
  RegistrationFormRoute({required bool asUpdate})
      : super(name,
            path: '/registrationForm',
            args: RegistrationFormRouteArgs(asUpdate: asUpdate));

  static const String name = 'RegistrationFormRoute';
}

class RegistrationFormRouteArgs {
  const RegistrationFormRouteArgs({required this.asUpdate});

  final bool asUpdate;
}

class AddressFormRoute extends _i1.PageRouteInfo<AddressFormRouteArgs> {
  AddressFormRoute({required bool asUpdate})
      : super(name,
            path: '/addressForm',
            args: AddressFormRouteArgs(asUpdate: asUpdate));

  static const String name = 'AddressFormRoute';
}

class AddressFormRouteArgs {
  const AddressFormRouteArgs({required this.asUpdate});

  final bool asUpdate;
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

class ItemRoute extends _i1.PageRouteInfo<ItemRouteArgs> {
  ItemRoute({required String itemJson, String? orderItemJson, _i2.Key? key})
      : super(name,
            path: '/item',
            args: ItemRouteArgs(
                itemJson: itemJson, orderItemJson: orderItemJson, key: key));

  static const String name = 'ItemRoute';
}

class ItemRouteArgs {
  const ItemRouteArgs({required this.itemJson, this.orderItemJson, this.key});

  final String itemJson;

  final String? orderItemJson;

  final _i2.Key? key;
}

class CartRoute extends _i1.PageRouteInfo {
  const CartRoute() : super(name, path: '/cart');

  static const String name = 'CartRoute';
}
