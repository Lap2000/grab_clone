import 'package:get/get.dart';
import 'package:grab_clone/controllers/shipper_role_controller/shipper_info_controller.dart';

class ShipperInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShipperInfoController());
  }
}
