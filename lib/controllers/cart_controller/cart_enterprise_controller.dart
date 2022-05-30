import 'dart:convert';

import 'package:get/get.dart';
import 'package:grab_clone/database/models/cart/cart_enterprise_model.dart';
import 'package:grab_clone/database/services/cart_services.dart';

class CartEnterpriseController extends GetxController {
  RxInt count = 0.obs;
  RxBool isLoading = false.obs;
  RxInt totalCart = 0.obs;
  RxString amountCart = ''.obs;
  //late CartList cartModelList = CartList();
  //List<CartModel> cartListModel = [];
  //late Rx<CartList> cartList = Rx<CartList>(cartListInModel);
  RxList<CartEnterpriseModel> cartEnterpriseList =
      RxList<CartEnterpriseModel>();

  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  increaseCount() {
    count++;
  }

  deleteItemInCart(CartEnterpriseModel cartEnterpriseModel) {
    cartEnterpriseList.remove(cartEnterpriseModel);
    Cartservices.deleteCartByEnterprise(eid: cartEnterpriseModel.eID);
  }

  getCart() async {
    isLoading(true);
    var data = await Cartservices.getCart();
    try {
      if (data != null) {
        data = jsonDecode(data)['data'];
        //print(data);
        List<dynamic> jsonResponse = data['data']['ListEnterpriseID'];
        // amountCart.value = data['data']['totalPrice'].toString();
        cartEnterpriseList.value = jsonResponse
            .map((item) => CartEnterpriseModel.fromMap(item))
            .toList();
      } else {}
    } finally {
      isLoading(false);
    }
  }
}
