import 'package:auto_route/auto_route.dart';

import '../../features/home/domain/repositories/petpooja_api_service.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/products/bd_page.dart';
import '../../features/home/presentation/pages/products/chicken_page.dart';
import '../../features/home/presentation/pages/products/ens_page.dart';
import '../../features/home/presentation/pages/products/mutton_page.dart';
import '../../features/home/presentation/pages/products/rtc_page.dart';
import '../../features/home/presentation/pages/products/seafood_page.dart';
import '../../features/login/presentation/pages/sign_in.dart';

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
