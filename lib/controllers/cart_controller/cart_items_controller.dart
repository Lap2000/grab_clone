import 'package:get/get.dart';
import 'package:grab_clone/database/models/cart/cart_model.dart';

class CartItemsController extends GetxController {
  //late Function() notifyParentController;
  late CartModel cartModel = CartModel(
      pImage: '', pTotal: 0, pPrice: 0, pAmount: 0, pName: '', pID: '');

  RxInt productAmount = 0.obs;
  RxInt productPrice = 0.obs;
  RxInt productTotal = 0.obs;

  void onReady() {
    productAmount.value = cartModel.pAmount!;
    super.onReady();
  }
}
