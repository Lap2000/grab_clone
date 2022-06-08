import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../database/services/account_services.dart';

class EnterpriseInfoController extends GetxController {
  var isLoading = false.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString userName = ''.obs;

  //String genderString ='Male';
  Rx<DateTime> dateOfBirth = DateTime.now().obs;

  @override
  void onInit() {
    doGetUserInfo();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> doGetUserInfo() async {
    isLoading.value = true;
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    //print('Đây là token : $value');
    try {
      var data = await Accountservices.getUserInfo(token: value);
      if (data != null) {
        var res = jsonDecode(data);
        //userName = res['userName'];
        name.value = res['data']['name'];
        userName.value = res['data']['userName'];
        email.value = res['data']['email'];
        phone.value = res['data']['phone'];
        dateOfBirth.value = DateTime.tryParse(res['data']['dateofBirth'])!;
      } else {
        Get.snackbar(
          "UserInfo",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
