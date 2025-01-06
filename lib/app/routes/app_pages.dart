// import 'package:get/get.dart';
// import 'package:get_cli_tutorial/app/modules/home/views/landingpageView.dart';
// import 'package:get_cli_tutorial/app/modules/home/views/signinViewPage.dart';
// import 'package:get_cli_tutorial/app/modules/home/views/splash_screen_view.dart';
//
// import '../modules/home/bindings/home_binding.dart';
// import '../modules/home/views/home_view.dart';
//
// part 'app_routes.dart';
//
// class AppPages {
//   AppPages._();
//
//   static const INITIAL = Routes.HOME;
//   // static const INITIAL = Routes.splashScreen;
//
//   static final routes = [
//     GetPage(
//       name: _Paths.HOME,
//       page: () => const HomeView(),
//       binding: HomeBinding(),
//     ),
//     GetPage(
//       name: _Paths.splashScreen,
//       page: () => const SplashScreenView(),
//       binding: HomeBinding(),
//     ),
//     GetPage(
//       name: _Paths.SignInPage,
//       page: () => const SignInView(),
//       binding: HomeBinding(),
//     ),
//     GetPage(
//       name: _Paths.LandingPage,
//       page: () => const LandingPage(),
//       binding: HomeBinding(),
//     ),
//   ];
// }
///-----------------
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/modules/home/views/landingpageView.dart';
import 'package:get_cli_tutorial/app/modules/home/views/signinView.dart';
import 'package:get_cli_tutorial/app/modules/home/views/splash_screen_view.dart';
import 'package:get_cli_tutorial/app/modules/nurseCall/bindings/nurse_call_binding.dart';
import 'package:get_cli_tutorial/app/modules/nurseCall/views/nurse_call_view.dart';
import 'package:get_cli_tutorial/app/modules/nurseCall/views/signinViewPage.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes .NurseCall;
  // static const INITIAL = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NurseCall,
      page: () =>  NurseCallView(),
      binding: NurseCallBinding(),
    ),
    GetPage(
      name: _Paths.splashScreen,
      page: () => const SplashScreenView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SignInViewPage,
      page: () => const SignInViewPage(),
      binding: NurseCallBinding(),
    ),

  ];
}
