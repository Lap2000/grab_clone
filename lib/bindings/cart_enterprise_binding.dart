import 'package:get/get.dart';

import '../controllers/cart_controller/cart_enterprise_controller.dart';

class CartEnterpriseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartEnterpriseController());
  }
}
