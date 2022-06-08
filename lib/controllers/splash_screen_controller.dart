import 'package:get/get.dart';

import '../routes/route.dart';

class SplashScreenController extends GetxController {
  RxDouble width = 50.0.obs;
  RxDouble height = 50.0.obs;

  RxDouble mWidth = 0.0.obs;
  RxDouble mFontSize = 0.0.obs;

  RxDouble textWidth = 150.0.obs;
  RxDouble textFontSize = 0.0.obs;
  RxDouble textMargin = 100.0.obs;

  RxDouble imageWidth = 100.0.obs;
  RxDouble imageMargin = 0.0.obs;

  @override
  void onInit() {
    getAnimation();
    super.onInit();
  }

  void getAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      width.value = 150;
      height.value = 150;
      Future.delayed(const Duration(seconds: 1), () {
        // container box
        mWidth.value = 90;
        mFontSize.value = 100;
        // text
        textWidth.value = 200;
        textMargin.value = 0;
        textFontSize.value = 20;
        //image
        imageWidth.value = 150;
        imageMargin.value = Get.width - 120;
        Future.delayed(const Duration(seconds: 5), () {
          Get.toNamed(AppRoutes.login);
        });
      });
    });
  }
}
