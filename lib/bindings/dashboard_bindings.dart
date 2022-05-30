import 'package:get/get.dart';
import 'package:grab_clone/controllers/dashboard_controller.dart';
import 'package:grab_clone/controllers/search_controller.dart';
import 'package:grab_clone/controllers/user_acount_controller/Information_persional_controller.dart';
import 'package:grab_clone/controllers/user_home_controller/news_controller.dart';

import '../controllers/user_acount_controller/account_controller.dart';
import '../controllers/user_home_controller/home_controller.dart';

class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => InformationController());
    Get.lazyPut(() => NewsController());
  }
}
