import 'package:get/get.dart';
import 'package:grab_clone/controllers/authController/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}