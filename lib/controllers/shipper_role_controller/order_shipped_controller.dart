import 'dart:convert';

import 'package:get/get.dart';
import 'package:grab_clone/database/services/shipper_services.dart';

import '../../database/models/order_user/order_model.dart';

class OrderShippedController extends GetxController {
  RxInt count = 0.obs;
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  //late CartList cartModelList = CartList();
  //List<CartModel> cartListModel = [];
  //late Rx<CartList> cartList = Rx<CartList>(cartListInModel);
  RxList<OrderModel> orderNotConfirmList = RxList<OrderModel>();
  RxList<OrderModel> orderConfirmList = RxList<OrderModel>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getOrderNotConfirm();
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getOrderNotConfirm() async {
    isLoading1(true);
    var data1 = await ShipperServices.getShipperConfirmOrder();
    try {
      if (data1 != null) {
        List<dynamic> jsonResponse = jsonDecode(data1)['data'];
        orderNotConfirmList.value =
            jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
      } else {}
    } finally {
      isLoading1(false);
    }
  }
}
