import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/product_services.dart';

import '../database/models/distant_model.dart';
import '../database/models/product_model.dart';

class SearchController extends GetxController {
  late TextEditingController findtextController;
  final isLoading = false.obs;
  final RxList<ProductDistance> productDistantsList = RxList<ProductDistance>();
  final userLat = ''.obs;
  final userLng = ''.obs;
  final findRSelected = 10.obs;

  void _handleCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case 'b':
        findtextController.text = command['command'];
        onFind2(command['command']);
        break;
      case 'bún':
        findtextController.text = command['command'];
        onFind2(command['command']);
        break;
      case 'cà phê':
        findtextController.text = command['command'];
        onFind2(command['command']);
        break;
    }
  }

  void setSelected(var value) {
    findRSelected.value = value;
    print(findRSelected.value);
  }

  void onInit() {
    findtextController = TextEditingController();
    AlanVoice.addButton(
        "8c0385a687600ad41ee4f8a31cc06bf92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
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
    print(userLat.value + " : " + userLng.value);
  }

  onFind() async {
    productDistantsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getFindProductList(
              productName: findtextController.text);
      if (!_futureOfList.isEmpty) {
        findProductLoop(_futureOfList);
      } else {
        Get.snackbar(
          "Search",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
          titleText: const Text(
            'Search',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Không tìm thấy sản phẩm !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  onFind2(String name) async {
    productDistantsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getFindProductList(productName: name);
      if (!_futureOfList.isEmpty) {
        findProductLoop(_futureOfList);
      } else {
        Get.snackbar(
          "Search",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
          titleText: const Text(
            'Search',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Không tìm thấy sản phẩm !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<double> getDistantItem(ProductModel product) async {
    dynamic enterprise =
        await ProductServices.getEnterpriseOfProduct(Eid: product.E_id);
    double distance = _coordinateDistance(double.parse(userLat.value),
        double.parse(userLng.value), enterprise['lat'], enterprise['lng']);
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

  Future<void> findProductLoop(List<ProductModel> ProductList) async {
    for (var i = 0; i < ProductList.length; i++) {
      dynamic enterprise = await ProductServices.getEnterpriseOfProduct(
          Eid: ProductList[i].E_id);
      double distance = _coordinateDistance(double.parse(userLat.value),
          double.parse(userLng.value), enterprise['lat'], enterprise['lng']);
      if (distance <= findRSelected.value) {
        productDistantsList
            .add(ProductDistance(product: ProductList[i], distance: distance));
      }
    }
    productDistantsList.sort((a, b) => a.distance.compareTo(b.distance));
    if (productDistantsList.length == 0) {
      Get.snackbar("Search", "Không tìm thấy sản phẩm trong vòng 10.km !",
          titleText: const Text(
            'Search',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Không tìm thấy sản phẩm trong vòng 10.km !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ));
    } else {
      Get.snackbar(
        "Search",
        "Đã tìm thấy sản phẩm !",
        titleText: const Text(
          'Search',
          style: TextStyle(color: Colors.green, fontSize: 25),
        ),
        messageText: const Text(
          "Đã tìm thấy sản phẩm !",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    }
  }
}
