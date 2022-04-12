


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/product_services.dart';

import '../database/models/distant_model.dart';
import '../database/models/product_model.dart';
import '../routes/route.dart';

class SearchController extends GetxController {
  late TextEditingController findtextController;
  final isLoading = false.obs;
  final RxList<ProductDistance> productDistantsList = RxList<ProductDistance>() ;
  final userLat = ''.obs;
  final userLng = ''.obs;


  void onInit() {
    findtextController = TextEditingController();
    getLocation();
    super.onInit();
  }

  void Dispose() {
    findtextController.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    final storage = new FlutterSecureStorage();
    userLat.value = (await storage.read(key: 'User_lat'))!;
    userLng.value = (await storage.read(key: 'User_lng'))!;
    print(userLat.value+" : "+userLng.value);
  }

  onFind() async {
    productDistantsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList = await ProductServices.getFindProductList(productName: findtextController.text);
      if (!_futureOfList.isEmpty) {
        findProductLoop(_futureOfList);
      } else {
        Get.snackbar("Search", "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
          titleText: Text(
            'Search', style: TextStyle(color: Colors.red, fontSize: 25),),
          messageText: Text('Không tìm thấy sản phẩm !',
            style: TextStyle(color: Colors.black, fontSize: 15),),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<double> getDistantItem(ProductModel ProductList) async {
    dynamic enterprise = await ProductServices.getEnterpriseOfProduct(Eid: ProductList.E_id);
    double distance = _coordinateDistance(double.parse(userLat.value),double.parse(userLng.value),enterprise['lat'],enterprise['lng']);
    return distance;
  }

  double _coordinateDistance(double lat1, double lon1, double lat2, double lon2) {
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((lat2 - lat1) * p) / 2 +
    //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    // var d = (12742 * asin(sqrt(a))).toStringAsFixed(1);
    // double e = double.parse(d);
    // return e;

    var distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);//distance in meters
    //print(distance);
    return distance/1000;
  }

  Future<void> findProductLoop(List<ProductModel> ProductList) async {
    for (var i = 0; i < ProductList.length; i++) {
      dynamic enterprise = await ProductServices.getEnterpriseOfProduct(Eid: ProductList[i].E_id);
      double distance = _coordinateDistance(double.parse(userLat.value),double.parse(userLng.value),enterprise['lat'],enterprise['lng']);
      if(distance <= 10){
        productDistantsList.add(ProductDistance(product: ProductList[i], distance: distance));
      }
    }
    productDistantsList.sort((a, b) => a.distance.compareTo(b.distance));
    if(productDistantsList.length ==0)
    {
      Get.snackbar("Search", "Không tìm thấy sản phẩm trong vòng 10.km !",
      titleText: Text(
      'Search', style: TextStyle(color: Colors.red, fontSize: 25),),
      messageText: Text('Không tìm thấy sản phẩm trong vòng 10.km !',
      style: TextStyle(color: Colors.black, fontSize: 15),));
    } else {
      Get.snackbar("Search", "Đã tìm thấy sản phẩm !",
        titleText: Text(
          'Search', style: TextStyle(color: Colors.green, fontSize: 25),),
        messageText: Text("Đã tìm thấy sản phẩm !",
          style: TextStyle(color: Colors.black, fontSize: 15),),
      );
    }
  }

}