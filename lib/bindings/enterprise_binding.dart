import 'package:get/get.dart';
import 'package:grab_clone/controllers/product_evalute/enterprise_controller.dart';

class EnterpriseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnterpriseController());
  }
}
