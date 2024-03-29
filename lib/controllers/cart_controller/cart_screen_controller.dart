import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/payment_binding.dart';
import 'package:grab_clone/database/models/cart/cart_model.dart';
import 'package:grab_clone/database/services/cart_services.dart';
import 'package:grab_clone/views/screens/dashboard/cart/payment_screen.dart';
import 'package:grab_clone/views/widgets/custom_successful_payment.dart';
import 'package:weather/weather.dart';

import '../../database/services/account_services.dart';
import '../../database/services/product_services.dart';

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
  RxInt shippingPrice = 0.obs;
  RxDouble distanceEnterprise = 0.0.obs;
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
    int? distance = int.tryParse(
        (await getDistantItem(eID.value, userLat.value, userLng.value))
            .toStringAsFixed(0));
    WeatherFactory wf = WeatherFactory("856822fd8e22db5e1ba48c0e7d69844a",
        language: Language.ENGLISH);
    Weather w = await wf.currentWeatherByLocation(
        double.parse(userLat.value), double.parse(userLng.value));
    // List<Weather> forecast = await wf.fiveDayForecastByLocation(
    //     double.parse(userLat.value), double.parse(userLng.value));
    // print('weather : ${w.weatherMain}');
    // print('weather : ${forecast.first.weatherMain}');
    // print('Time : ${DateTime.now().hour}');
    print(distance);
    if ((DateTime.now().hour <= 12 && DateTime.now().hour >= 11) ||
        (DateTime.now().hour <= 19 && DateTime.now().hour >= 18)) {
      if (distance! <= 3) {
        if (w.weatherMain == 'Rain') {
          shippingPrice.value =
              int.parse((17000 * 120 / 100 / 1000).toStringAsFixed(0)) * 1000;
        } else
          shippingPrice.value = 17000;
      } else {
        if (w.weatherMain == 'Rain') {
          shippingPrice.value = int.parse(
                  ((17000 + ((distance - 3) * 5000)) * 120 / 100 / 1000)
                      .toStringAsFixed(0)) *
              1000;
        } else
          shippingPrice.value = 17000 + ((distance - 3) * 5000);
      }
      shippingPrice.value = int.parse(
              (shippingPrice.value * 120 / 100 / 1000).toStringAsFixed(0)) *
          1000;
      totalCart.value = int.parse(
              ((totalCart.value + shippingPrice.value) / 1000)
                  .toStringAsFixed(0)) *
          1000;
    } else {
      if (distance! <= 3) {
        if (w.weatherMain == 'Rain') {
          shippingPrice.value =
              int.parse((17000 * 120 / 100 / 1000).toStringAsFixed(0)) * 1000;
        } else
          shippingPrice.value = 17000;
      } else {
        if (w.weatherMain == 'Rain') {
          shippingPrice.value = int.parse(
                  ((17000 + ((distance - 3) * 5000)) * 120 / 100 / 1000)
                      .toStringAsFixed(0)) *
              1000;
        } else
          shippingPrice.value = 17000 + ((distance - 3) * 5000);
      }
      totalCart.value = totalCart.value + shippingPrice.value;
    }
  }

  Future<double> getDistantItem(eID, lat, lng) async {
    dynamic enterprise = await ProductServices.getEnterpriseOfProduct(Eid: eID);
    double distance = _coordinateDistance(double.parse(lat), double.parse(lng),
        enterprise['lat'], enterprise['lng']);
    //print(distance);
    distanceEnterprise.value = double.tryParse((distance).toStringAsFixed(2))!;
    return distance;
  }

  double _coordinateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((lat2 - lat1) * p) / 2 +
    //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    // var d = (12742 * asin(sqrt(a))).toStringAsFixed(1);
    // double e = double.parse(d);
    // return e;

    var distance =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2); //distance in meters
    //print(distance);
    return distance / 1000;
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
          totalCart.value =
              totalCart.value + int.parse((total).toStringAsFixed(0));
        } catch (e) {
          print('Lap-$e');
        }
      } else {}
    } finally {
      isLoading(false);
    }
  }

  placeOrder({required BuildContext context, required payType}) async {
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
      var data = await Cartservices.placeOrder2(
        name: name.value,
        phone: phoneNumber.value,
        lat: userLat.value,
        lng: userLng.value,
        enterpriseName: eName.value,
        location: locationController.text,
        orderDetail: jsonDataList,
        totalPrice: totalCart.value,
        eID: eID.value,
        context: context,
        shipCost: shippingPrice.value,
        payType: payType,
      );
      if (jsonDecode(data)['data'] != null && payType == 1) {
        final result = await Get.to(
            () => PaymentScreen(url: jsonDecode(data)['data']),
            binding: PaymentBinding());
        if (result == true) {
          final rst = await Get.to(() => const CustomSuccessfulPayment());
          if (rst == true) {
            Get.back(result: true);
          }
        }
      } else if (jsonDecode(data)['data'] != null && payType == 0) {
        Get.back(result: 'true');
      }
      try {} finally {
        isOrder(false);
      }
    }
  }
}
