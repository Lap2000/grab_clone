import 'package:get/get.dart';
import 'package:grab_clone/controllers/product_evalute/product_evalute_controller.dart';

class EvaluateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EvaluteController());
  }
}
