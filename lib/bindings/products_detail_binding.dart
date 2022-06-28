import 'package:get/get.dart';
import 'package:grab_clone/controllers/products_detail_controller.dart';

class ProductsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsDetailController());
  }
}
