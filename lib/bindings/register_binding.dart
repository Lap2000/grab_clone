import 'package:get/get.dart';
import 'package:grab_clone/controllers/authController/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}