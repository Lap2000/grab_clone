import 'package:get/get.dart';
import 'package:grab_clone/database/models/enterprise_model.dart';
import 'package:grab_clone/database/models/product_model.dart';

import '../../database/services/product_services.dart';

class EnterpriseController extends GetxController {
  late EnterpriseModel eModel = EnterpriseModel(name: '', phone: '', id: '');
  late Rx<EnterpriseModel> enterpriseModel = Rx(eModel);
  late RxList<ProductModel> productList = RxList<ProductModel>();
  final isLoading = false.obs;
  final RxString idEnterprise = ''.obs;

  void onInit() {
    super.onInit();
  }

  void onReady() {
    onGetEnterprise();
    super.onReady();
  }

  void Dispose() {
    super.dispose();
  }

  onGetEnterprise() async {
    isLoading(true);
    try {
      enterpriseModel.value =
          (await ProductServices.getEnterPrise(id: idEnterprise.value))!;
      List<ProductModel> _futureOfList =
          await ProductServices.getProductListOfEnterprise(
              id: idEnterprise.value);
      productList.value = _futureOfList;
      if (!_futureOfList.isEmpty) {
        print(productList.value.length);
      } else {
        print('Lap - ' + _futureOfList.toString());
      }
    } finally {
      isLoading(false);
    }
  }
}
