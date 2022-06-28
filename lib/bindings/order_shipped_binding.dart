import 'package:get/get.dart';

import '../controllers/shipper_role_controller/order_shipped_controller.dart';

class OrderShippedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderShippedController());
  }
}
