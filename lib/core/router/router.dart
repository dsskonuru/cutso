import 'package:auto_route/auto_route.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/home/presentation/pages/category_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/item_page.dart';
import '../../features/login/presentation/pages/mobile_form_page.dart';
import '../../features/login/presentation/pages/otp_form_page.dart';
import '../../features/login/presentation/pages/registration_form_page.dart';
import '../../features/login/presentation/pages/registration_form_page_2.dart';
import '../../features/login/presentation/pages/sign_in.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // AutoRoute(path: '/', page: MyApiPage),
    AutoRoute(
      path: '/',
      name: "LoginRouter",
      page: LoginWrapperPage,
      // guards: [AuthGuard],
      children: [
        RedirectRoute(path: '', redirectTo: '/'),
        AutoRoute(path: '', page: MobileFormPage),
        AutoRoute(path: 'otp', page: OtpFormPage),
        AutoRoute(path: 'registration1', page: RegistrationFormPage),
        AutoRoute(path: 'registration2', page: RegistrationForm2Page),
      ],
    ),
    AutoRoute(path: '/home', page: HomePage),
    AutoRoute(path: '/category', page: CategoryPage),
    AutoRoute(path: '/item', page: ItemPage),
    AutoRoute(path: '/cart', page: CartPage),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
