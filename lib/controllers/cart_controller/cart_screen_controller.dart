import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/models/cart/cart_model.dart';
import 'package:grab_clone/database/services/cart_services.dart';

import '../../database/services/account_services.dart';

class CartController extends GetxController {
  RxInt count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isOrder = false.obs;
  final userLat = ''.obs;
  final userLng = ''.obs;
  late TextEditingController locationController;
  RxString name = ''.obs;
  RxString phoneNumber = ''.obs;
  RxInt totalCart = 0.obs;
  RxString amountCart = ''.obs;
  RxString eID = ''.obs;
  RxString eName = ''.obs;
  RxString tokenUser = ''.obs;
  //late CartList cartModelList = CartList();
  //List<CartModel> cartListModel = [];
  //late Rx<CartList> cartList = Rx<CartList>(cartListInModel);
  RxList<CartModel> cartList = RxList<CartModel>();
  final locationFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    locationController = TextEditingController();
    doGetUserInfo();
    getLocation();
    super.onInit();
  }

  @override
  void onReady() {
    getCart();
    super.onReady();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  increaseCount() {
    count++;
  }

  String? validateNull(String value) {
    if (value == '') {
      return "Điền địa chỉ chính xác để giao hàng !";
    } else {
      return null;
    }
  }

  Future<void> getLocation() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    tokenUser.value = token!;
    userLat.value = (await storage.read(key: 'User_lat'))!;
    userLng.value = (await storage.read(key: 'User_lng'))!;
    print(userLat.value + " : " + userLng.value);
  }

  deleteIteminCart(CartModel cartModel) {
    cartList.remove(cartModel);
    totalCart.value =
        totalCart.value - int.parse(cartModel.pTotal!.toStringAsFixed(0));
    //cartList.value.removeAt(index);
  }

  addCountIteminCart(CartModel cartModel) async {
    for (int i = 0; i < cartList.length; i++) {
      if (cartModel.pID == cartList[i].pID) {
        cartList[i].pAmount = cartList[i].pAmount! + 1;
        cartList[i].pTotal = cartList[i].pTotal! + cartList[i].pPrice!;
        CartModel c = cartList[i];
        cartList[i] = c;
        //await cartList.removeAt(i);
        //cartList.add(c);
        totalCart.value =
            totalCart.value + int.parse(cartList[i].pPrice!.toStringAsFixed(0));
        break;
      }
    }
    Cartservices.EditProductInCart(
        pID: cartModel.pID,
        pAmount: cartModel.pAmount!,
        token: tokenUser.value);
  }

  subCountIteminCart(CartModel cartModel) async {
    for (int i = 0; i < cartList.length; i++) {
      if (cartModel.pID == cartList[i].pID) {
        if (cartList[i].pAmount == 1) {
          Get.snackbar(
            "",
            "",
            titleText: const Text(
              'Giỏ hàng',
              style: TextStyle(color: Colors.yellow, fontSize: 25),
            ),
            messageText: const Text(
              'Số lượng đã tối thiểu không thể giảm nữa!',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
          break;
        } else {
          cartList[i].pAmount = cartList[i].pAmount! - 1;
          cartList[i].pTotal = cartList[i].pTotal! - cartList[i].pPrice!;
          CartModel c = cartList[i];
          cartList[i] = c;
          //await cartList.removeAt(i);
          //cartList.add(c);
          totalCart.value = totalCart.value -
              int.parse(cartList[i].pPrice!.toStringAsFixed(0));
          Cartservices.EditProductInCart(
              pID: cartModel.pID,
              pAmount: cartModel.pAmount!,
              token: tokenUser.value);
          break;
        }
      }
    }
  }

  doGetUserInfo() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    //print('Đây là token : $value');
    try {
      var data = await Accountservices.getUserInfo(token: value);
      var res = jsonDecode(data);
      name.value = res['data']['name'];
      phoneNumber.value = res['data']['phone'];
    } finally {
      //update();
    }
  }

  getCart() async {
    isLoading(true);
    print(eID);
    var data = await Cartservices.getCartByEnterprise(eid: eID.value);
    try {
      if (data != null) {
        List<dynamic> jsonResponse = jsonDecode(data)['data']['data'];
        // try {
        //   totalCart.value = int.parse(data['data']['totalPrice'].toString());
        // } catch (e) {
        //   print('Lap-$e');
        // }
        // amountCart.value = data['data']['totalPrice'].toString();
        cartList.value =
            jsonResponse.map((item) => CartModel.fromMap(item)).toList();
        double total = 0;
        for (int i = 0; i < cartList.value.length; i++) {
          total = total + cartList.value[i].pTotal!;
        }
        try {
          totalCart.value = int.parse(total.toStringAsFixed(0));
        } catch (e) {
          print('Lap-$e');
        }
      } else {}
    } finally {
      isLoading(false);
    }
  }

  placeOrder({required BuildContext context}) async {
    bool isValidate = locationFormKey.currentState!.validate();
    if (isValidate) {
      isOrder(true);
      // List jsonDataList = cartList
      //     .map((cartOrder) => cartOrder.toJson().values.toList())
      //     .toList();
      List jsonDataList =
          cartList.value.map((cartOrder) => cartOrder.toMap()).toList();
      print(jsonDataList);
      //String jsonArray = jsonEncode(cartList);
      //print(jsonArray);
      //Array<dynamic> cart = cartList.value as Array<dynamic>;
      var data = await Cartservices.placeOrder(
          name: name.value,
          phone: phoneNumber.value,
          lat: userLat.value,
          lng: userLng.value,
          enterpriseName: eName.value,
          location: locationController.text,
          orderDetail: jsonDataList,
          totalPrice: totalCart.value,
          eID: eID.value,
          context: context);
      try {} finally {
        isOrder(false);
      }
    }
  }
}
