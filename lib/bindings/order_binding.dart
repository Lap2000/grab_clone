import 'package:get/get.dart';
import 'package:grab_clone/controllers/order_controller/order_screen_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
