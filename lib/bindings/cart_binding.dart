import 'package:get/get.dart';
import 'package:grab_clone/controllers/cart_controller/cart_items_controller.dart';

import '../controllers/cart_controller/cart_screen_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CartItemsController>(() => CartItemsController());
  }
}
