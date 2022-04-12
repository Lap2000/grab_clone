

import 'package:get/get.dart';
import 'package:grab_clone/controllers/acountController/InformationPersional_controller.dart';
import 'package:grab_clone/controllers/acountController/account_controller.dart';
import 'package:grab_clone/controllers/dashboard_controller.dart';
import 'package:grab_clone/controllers/homeController/home_controller.dart';
import 'package:grab_clone/controllers/homeController/news_controller.dart';
import 'package:grab_clone/controllers/map_controller.dart';
import 'package:grab_clone/controllers/search_controller.dart';

class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => InformationController());
    Get.lazyPut(() => NewsController());
    //Get.lazyPut(() => MapController());
  }

}