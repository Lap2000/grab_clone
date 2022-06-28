import 'package:get/get.dart';
import 'package:grab_clone/controllers/order_controller/order_detail_controller.dart';

class OrderDetailBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController());
  }
}
