import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/auth_services.dart';

import '../../views/screens/auth/verify_email.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final RegisterFormKey = GlobalKey<FormState>();

  late TextEditingController nameController,
      userNameController,
      emailController,
      userPwdController,
      confirmPasswordController;
  String name = '',
      email = '',
      userName = '',
      userPwd = '',
      confirmPassword = '';

  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    nameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    userPwdController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    userPwdController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Sai định dạng email !";
    } else if (value == '') {
      return "Không để trống !";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value == '') {
      return "Không để trống !";
    } else if (value.length <= 5) {
      return "Mật khẩu quá ngắn !";
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String value) {
    if (value == '') {
      return "Không để trống !";
    } else if (value.length <= 5) {
      return "Mật khẩu quá ngắn !";
    } else if (value != confirmPasswordController.text) {
      return "Mật khẩu nhập lại không trùng khớp!";
    } else {
      return null;
    }
  }

  String? validateNull(String value) {
    if (value == '') {
      return "Không để trống !";
    } else {
      return null;
    }
  }

  doRegister() async {
    bool isValidate = RegisterFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        var data = await AuthServices.register(
            name: nameController.text,
            userName: userNameController.text,
            email: emailController.text,
            userPwd: userPwdController.text,
            confirmPassword: confirmPasswordController.text);
        if (data != null) {
          //await storage.write(key: "name", value: data);
          RegisterFormKey.currentState!.save();
          var result = await Get.to(
            () => VerifyEmailScreen(email: emailController.text),
          );
          if (result == true) {
            Get.back();
            Get.snackbar(
              "Verify Email",
              "",
              titleText: const Text(
                'Verify Email',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Xác nhận Email thành công !',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          }
        } else {
          Get.snackbar(
            "Register",
            "Có lỗi xảy ra ! Kiểm tra lại thông tin.(Email - Username)",
            titleText: const Text(
              'Register',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: const Text(
              'Có lỗi xảy ra ! Kiểm tra lại thông tin.(Email - Username)',
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
