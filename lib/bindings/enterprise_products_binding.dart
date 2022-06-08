import 'package:get/get.dart';

import '../controllers/enterprise_role_controller/enterprise_products_controller.dart';

class EnterpriseProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnterpriseProductsController());
  }
}
