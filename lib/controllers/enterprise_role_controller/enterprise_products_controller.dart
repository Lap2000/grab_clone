import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../database/models/product_model.dart';
import '../../database/services/product_services.dart';

class EnterpriseProductsController extends GetxController {
  final isLoading = false.obs;
  final RxList<ProductModel> productsList = RxList<ProductModel>();
  Map<int, bool> pList = Map<int, bool>().obs;
  final RxString token = ''.obs;

  void onInit() {
    super.onInit();
    onGetProductList();
  }

  void Dispose() {
    super.dispose();
  }

  onGetProductList() async {
    productsList.value.clear();
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    token.value = value!;
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getEnterpriseProductList();
      productsList.value = _futureOfList;
    } finally {
      isLoading(false);
    }
  }

  onChangeProductStatus(String id) async {
    try {
      await ProductServices.changeProductStatus(id: id, token: token.value);
    } finally {}
  }
}
