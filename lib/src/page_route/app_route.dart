import 'package:get/get.dart';
import 'package:lab_app/src/page/auth/view/sign_in_screen.dart';
import 'package:lab_app/src/page/auth/view/sign_up_screen.dart';
import 'package:lab_app/src/page/base/base_screen.dart';
import 'package:lab_app/src/page/home/binding/home_binding.dart';
import 'package:lab_app/src/page/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashroute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signinroute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signuproute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseroute,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static String splashroute = "/splash";
  static String signinroute = "/signin";
  static String signuproute = "/signup";
  static String baseroute = "/";
}
