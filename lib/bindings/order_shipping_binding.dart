import 'package:get/get.dart';

import '../controllers/shipper_role_controller/order_shipping_controller.dart';

class OrderShippingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderShippingController());
  }
}
