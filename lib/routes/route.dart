import 'package:get/get.dart';
import 'package:grab_clone/bindings/dashboard_bindings.dart';
import 'package:grab_clone/bindings/forgot_password_binding.dart';
import 'package:grab_clone/bindings/login_binding.dart';
import 'package:grab_clone/bindings/register_binding.dart';
import 'package:grab_clone/views/screens/auth/forgot_password.dart';
import 'package:grab_clone/views/screens/auth/login.dart';
import 'package:grab_clone/views/screens/auth/register.dart';
import 'package:grab_clone/views/screens/dashboard/account/changeInfomationPersional/change_infomationPersional.dart';
import 'package:grab_clone/views/screens/dashboard/dashboard.dart';
import 'package:grab_clone/views/screens/splash_screen.dart';

import '../bindings/splash_screen_binding.dart';

class AppRoutes {
  static const login = Routes.login;
  static const register = Routes.register;

  static const dashboard = Routes.dashboard;
  static const informationPersional = Routes.informationPersional;
  static const map = Routes.map;
  static const splash = Routes.splash;
  static const forgot = Routes.forgot;
  // static const home = Routes.home;
  // static const search = Routes.search;
  // static const account = Routes.account;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => Register(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.forgot,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashBoardPage(),
      binding: DashBoardBindings(),
    ),
    GetPage(
      name: Routes.informationPersional,
      page: () => ChangeInfamationPersional(),
      binding: DashBoardBindings(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    //GetPage(name: Routes.map, page: () => MapPage(), binding: DashBoardBindings()),
    // GetPage(name: Routes.home, page: () => HomePage(), binding: DashBoardBindings()),
    // GetPage(name: Routes.search, page: () => SearchPage(), binding: DashBoardBindings()),
    // GetPage(name: Routes.account, page: () => AccountPage(), binding: DashBoardBindings()),
  ];
}

class Routes {
  static const register = '/register';
  static const login = '/login';
  // static const home = '/home';
  // static const search = '/search';
  //static const account = '/account';
  static const dashboard = '/dashboard';
  static const informationPersional = '/info';
  static const map = '/map';
  static const splash = '/splash';
  static const forgot = '/forgot';
}
