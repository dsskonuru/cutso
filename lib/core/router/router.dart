import 'package:auto_route/auto_route.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/home/presentation/pages/category_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/item_page.dart';
import '../../features/login/presentation/pages/address_form_page.dart';
import '../../features/login/presentation/pages/mobile_form_page.dart';
import '../../features/login/presentation/pages/onboarding_page.dart';
import '../../features/login/presentation/pages/otp_form_page.dart';
import '../../features/login/presentation/pages/registration_form_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: OnboardingPage),
    AutoRoute(path: '/mobileForm', page: MobileFormPage),
    AutoRoute(path: '/otpForm', page: OtpFormPage),
    AutoRoute(path: '/registrationForm', page: RegistrationFormPage),
    AutoRoute(path: '/addressForm', page: AddressFormPage),
    AutoRoute(path: '/home', page: HomePage, initial: true),
    AutoRoute(path: '/category', page: CategoryPage),
    AutoRoute(path: '/item', page: ItemPage),
    AutoRoute(path: '/profile', page: ProfilePage),
    AutoRoute(path: '/cart', page: CartPage),
  ],
)
class $AppRouter {}
