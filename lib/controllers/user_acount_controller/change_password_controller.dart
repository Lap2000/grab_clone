import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/account_services.dart';

class ChangePasswordController extends GetxController {
  RxBool passwordVisible = true.obs;
  RxBool isLoading = false.obs;

  final changePasswordFormKey = GlobalKey<FormState>();

  late TextEditingController OldPasswordontroller,
      NewPasswordController,
      ConfirmPasswordController;

  @override
  void onInit() {
    OldPasswordontroller = TextEditingController();
    NewPasswordController = TextEditingController();
    ConfirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void Dispose() {
    OldPasswordontroller.dispose();
    NewPasswordController.dispose();
    ConfirmPasswordController.dispose();
    super.dispose();
  }

  passwordVisibleChange() {
    passwordVisible.value = !passwordVisible.value;
  }

  String? validatePassword(String value) {
    if (value == '') {
      return "Empty Password !";
    } else {
      return null;
    }
  }

  doChangePassword() async {
    bool isValidate = changePasswordFormKey.currentState!.validate();
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if (isValidate) {
      isLoading(true);
      try {
        var data = await Accountservices.changePassword(
            confirmPass: ConfirmPasswordController.text,
            oldPass: OldPasswordontroller.text,
            newPass: NewPasswordController.text,
            token: value);
        print('$data + ${data.runtimeType}');

        if (data == 'Đổi mật khẩu thành công!') {
          changePasswordFormKey.currentState!.save();
          Get.snackbar(
            "Change Password",
            "!",
            titleText: Text(
              'Change Password',
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            messageText: Text(
              data,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        } else {
          Get.snackbar(
            "Change Password",
            "!",
            titleText: Text(
              'Change Password',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: Text(
              data,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }
}
