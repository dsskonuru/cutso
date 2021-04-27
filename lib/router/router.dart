import 'package:auto_route/auto_route.dart';
import '../services/petpooja_api_service.dart';

import '../screens/home/home_page.dart';
import '../screens/sign_in/sign_in.dart';

import '../screens/products/bd_page.dart';
import '../screens/products/chicken_page.dart';
import '../screens/products/ens_page.dart';
import '../screens/products/mutton_page.dart';
import '../screens/products/rtc_page.dart';
import '../screens/products/seafood_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MyApiPage),
    AutoRoute(
      path: '/login',
      name: "LoginRouter",
      page: LoginWrapperPage,
      // guards: [AuthGuard],
      children: [
        RedirectRoute(path: '', redirectTo: '/'),
        AutoRoute(path: '', page: MobileFormPage),
        AutoRoute(path: 'otp', page: OtpFormPage),
        AutoRoute(path: 'registration', page: RegistrationFormPage),
      ],
    ),
    // userDataRoutes,
    AutoRoute(path: '/home', page: HomePage),
    AutoRoute(path: '/chicken', page: ChickenPage),
    AutoRoute(path: '/mutton', page: MuttonPage),
    AutoRoute(path: '/sea-food', page: SeaFoodPage),
    AutoRoute(path: '/bd', page: BestDealsPage),
    AutoRoute(path: '/ens', page: EggsNSidesPage),
    AutoRoute(path: '/rtc', page: ReadyToCookPage),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
