import 'package:get/get.dart';

class ProductsDetailController extends GetxController {
  RxDouble price = 0.0.obs;
  RxString sizeP = 'Vừa'.obs;
  RxBool isLarge = false.obs;

  onChangeSize(bool size) {
    if (isLarge.value == size) {
    } else {
      if (isLarge.value == true) {
        price.value = price.value - 10000;
        sizeP.value = 'Vừa';
      } else if (isLarge.value == false) {
        price.value = price.value + 10000;
        sizeP.value = 'Lớn';
      }
      isLarge.value = size;
    }
  }
}
