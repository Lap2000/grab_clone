import 'package:get/get.dart';
import 'package:grab_clone/controllers/enterprise_role_controller/enterprise_info_controller.dart';

class EnterpriseInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnterpriseInfoController());
  }
}
