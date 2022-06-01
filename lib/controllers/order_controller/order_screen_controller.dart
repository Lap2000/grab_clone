import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/models/order_user/order_model.dart';
import 'package:grab_clone/database/services/order_services.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt count = 0.obs;
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  //late CartList cartModelList = CartList();
  //List<CartModel> cartListModel = [];
  //late Rx<CartList> cartList = Rx<CartList>(cartListInModel);
  RxList<OrderModel> orderNotConfirmList = RxList<OrderModel>();
  RxList<OrderModel> orderConfirmList = RxList<OrderModel>();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    getOrderNotConfirm();
    getOrderConfirm();
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getOrderNotConfirm() async {
    isLoading1(true);
    var data1 = await OrderServices.getNotConfirmOrderByDate();
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

  getOrderConfirm() async {
    isLoading2(true);
    var data2 = await OrderServices.getOrderByDate();
    try {
      if (data2 != null) {
        List<dynamic> jsonResponse = jsonDecode(data2)['data'];
        orderConfirmList.value =
            jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
      } else {}
    } finally {
      isLoading2(false);
    }
  }
}
