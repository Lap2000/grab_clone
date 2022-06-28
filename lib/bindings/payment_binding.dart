import 'package:get/get.dart';
import 'package:grab_clone/controllers/cart_controller/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}
