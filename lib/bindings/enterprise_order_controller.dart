import 'package:get/get.dart';

import '../controllers/enterprise_role_controller/enterprise_order_controller.dart';

class EnterpriseOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnterpriseOrderController());
  }
}
