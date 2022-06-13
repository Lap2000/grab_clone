import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../database/models/distant_model.dart';
import '../../database/models/product_model.dart';
import '../../database/services/product_services.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final RxList<ProductDistance> productDistantsList = RxList<ProductDistance>();
  final RxList<ProductDistance> foodProductDistantsList =
      RxList<ProductDistance>();
  final RxList<ProductDistance> waterproductDistantsList =
      RxList<ProductDistance>();
  final RxList<ProductDistance> suggestedproductDistantsList =
      RxList<ProductDistance>();
  final userLat = ''.obs;
  final userLng = ''.obs;

  void onInit() {
    getLocation();
    onGetSuggestedProducts();
    onGetProduct();
    onGetProductByType('Thực phẩm', foodProductDistantsList);
    onGetProductByType('Đồ uống', waterproductDistantsList);
    super.onInit();
  }

  void onReady() {
    super.onReady();
  }

  void Dispose() {
    super.dispose();
  }

  void getLocation() async {
    final storage = new FlutterSecureStorage();
    userLat.value = (await storage.read(key: 'User_lat'))!;
    userLng.value = (await storage.read(key: 'User_lng'))!;
    print(userLat.value + " : " + userLng.value);
  }

  void getAddress() async {
    double? lat = 0.0;
    double? lng = 0.0;
    try {
      lat = double.tryParse(userLat.value);
      lng = double.tryParse(userLng.value);
      List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
      //print(placemarks);
      Placemark place = placemarks[0];
      var Address =
          '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      print(Address);
    } catch (e) {
      print(e);
    }
  }

  onGetProduct() async {
    productDistantsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getAllProductList();
      if (!_futureOfList.isEmpty) {
        findProductLoop(_futureOfList, productDistantsList);
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
      getAddress();
    }
  }

  onGetSuggestedProducts() async {
    suggestedproductDistantsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getSuggestedProducts();
      if (!_futureOfList.isEmpty) {
        findSuggestedProductsLoop(_futureOfList, suggestedproductDistantsList);
      } else {}
    } finally {
      isLoading(false);
      getAddress();
    }
  }

  onGetProductByType(String type, List<ProductDistance> productDstList) async {
    productDstList.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getProductListByType(type: type);
      if (!_futureOfList.isEmpty) {
        findProductLoop(_futureOfList, productDstList);
      } else {}
    } finally {
      isLoading(false);
    }
  }

  Future<double> getDistantItem(ProductModel productList) async {
    dynamic enterprise =
        await ProductServices.getEnterpriseOfProduct(Eid: productList.E_id);
    double distance = _coordinateDistance(double.parse(userLat.value),
        double.parse(userLng.value), enterprise['lat'], enterprise['lng']);
    return distance;
  }

  double _coordinateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var distance =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2); //distance in meters
    return distance / 1000;
  }

  Future<void> findProductLoop(List<ProductModel> ProductList,
      List<ProductDistance> productDstList) async {
    for (var i = 0; i < ProductList.length; i++) {
      dynamic enterprise = await ProductServices.getEnterpriseOfProduct(
          Eid: ProductList[i].E_id);
      double distance = _coordinateDistance(double.parse(userLat.value),
          double.parse(userLng.value), enterprise['lat'], enterprise['lng']);
      if (distance <= 10) {
        productDstList
            .add(ProductDistance(product: ProductList[i], distance: distance));
      }
    }
    productDstList.sort((a, b) => a.distance.compareTo(b.distance));
    if (productDstList.length == 0) {
      Get.snackbar("Search", "Không tìm thấy sản phẩm trong vòng 10.km !",
          titleText: const Text(
            'Search',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Không tìm thấy sản phẩm trong vòng 10.km !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ));
    } else {}
  }

  Future<void> findSuggestedProductsLoop(List<ProductModel> ProductList,
      List<ProductDistance> productDstList) async {
    for (var i = 0; i < ProductList.length; i++) {
      dynamic enterprise = await ProductServices.getEnterpriseOfProduct(
          Eid: ProductList[i].E_id);
      double distance = _coordinateDistance(double.parse(userLat.value),
          double.parse(userLng.value), enterprise['lat'], enterprise['lng']);

      productDstList
          .add(ProductDistance(product: ProductList[i], distance: distance));
      productDstList.sort((a, b) => a.distance.compareTo(b.distance));
    }
    if (productDstList.length == 0) {
      Get.snackbar(
        "Search",
        "Không tìm thấy sản phẩm trong vòng 10.km !",
        titleText: const Text(
          'Search',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        messageText: const Text(
          'Không tìm thấy sản phẩm trong vòng 10.km !',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    } else {}
  }
}
