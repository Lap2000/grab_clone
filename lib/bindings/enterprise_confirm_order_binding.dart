import 'package:get/get.dart';
import 'package:grab_clone/controllers/enterprise_role_controller/enterprise_confirm_order_controller.dart';

class EnterpriseConfirmOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnterpriseConfirmOrderController());
  }
}
