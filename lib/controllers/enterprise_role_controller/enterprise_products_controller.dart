import 'package:get/get.dart';

import '../../database/models/product_model.dart';
import '../../database/services/product_services.dart';

class EnterpriseProductsController extends GetxController {
  final isLoading = false.obs;
  final RxList<ProductModel> productsList = RxList<ProductModel>();

  void onInit() {
    super.onInit();
    onGetProductList();
  }

  void Dispose() {
    super.dispose();
  }

  onGetProductList() async {
    productsList.value.clear();
    isLoading(true);
    try {
      List<ProductModel> _futureOfList =
          await ProductServices.getEnterpriseProductList();
      productsList.value = _futureOfList;
    } finally {
      isLoading(false);
    }
  }
}
