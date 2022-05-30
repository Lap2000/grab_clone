import 'package:get/get.dart';

import '../controllers/user_acount_controller/change_password_controller.dart';

class ChangePasswordBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
