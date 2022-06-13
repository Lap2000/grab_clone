import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/auth_services.dart';

class ForgotPasswordController extends GetxController {
  late RxBool isSendOTP = false.obs;
  late RxBool isLoading = false.obs;
  late RxInt timeCounter = 60.obs;
  late TextEditingController emailController;
  late TextEditingController newPwdController;
  late TextEditingController confirmPwdController;
  late TextEditingController otpController;
  final forgotFormKey = GlobalKey<FormState>();
  late Timer timer;
  late String email = '';

  @override
  onInit() {
    super.onInit();
    emailController = TextEditingController();
    newPwdController = TextEditingController();
    confirmPwdController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    newPwdController.dispose();
    confirmPwdController.dispose();
    otpController.dispose();
    timer.cancel();
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
    } else if (value != confirmPwdController.text) {
      return "Mật khẩu nhập lại không trùng khớp!";
    } else {
      return null;
    }
  }

  String? validateOTP(String value) {
    if (value == '') {
      return "Không để trống !";
    } else if (value.length != 5) {
      return "OTP không đúng độ dài !";
    } else {
      try {
        int.parse(value);
        return null;
      } catch (e) {
        return "Sai định dạng !";
      }
      return null;
    }
  }

  onSendOTP() async {
    if (emailController.text == '') {
      Get.snackbar(
        "Email",
        "",
        titleText: const Text(
          'Email',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        messageText: const Text(
          'Không để trống Email !',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    } else if (!GetUtils.isEmail(emailController.text)) {
      return Get.snackbar(
        "Email",
        "",
        titleText: const Text(
          'Email',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        messageText: const Text(
          'Email sai định dạng !',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
    } else {
      if (isSendOTP.value == true) {
      } else {
        isSendOTP(true);
        var res =
            await AuthServices.forgotPassword(email: emailController.text);
        if (res.statusCode == 200) {
          email = emailController.text;
          const oneSec = Duration(seconds: 1);
          timer = Timer.periodic(
            oneSec,
            (Timer timer) {
              if (timeCounter.value == 0) {
                isSendOTP(false);
                timer.cancel();
                timeCounter.value = 60;
              } else {
                timeCounter.value--;
              }
            },
          );
          var stringOject = jsonDecode(res.body)['message'];
          Get.snackbar(
            "Email",
            "",
            titleText: const Text(
              'Email',
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            messageText: Text(
              stringOject,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        } else {
          var stringOject = jsonDecode(res.body)['message'];
          Get.snackbar(
            "Email",
            "",
            titleText: const Text(
              'Email',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: Text(
              stringOject,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        }
      }
    }
  }

  onResetPassword() async {
    bool isValidate = forgotFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        var res = await AuthServices.resetPassword(
            email: email,
            password: newPwdController.text,
            confirmPassword: confirmPwdController.text,
            otp: otpController.text);
        if (res.statusCode == 200) {
          var stringOject = jsonDecode(res.body)['message'];
          Get.back();
          Get.snackbar(
            "Reset Password",
            "",
            titleText: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            messageText: Text(
              stringOject,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        } else {
          var stringOject = jsonDecode(res.body)['message'];
          Get.snackbar(
            "Reset Password",
            "",
            titleText: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: Text(
              stringOject,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }
}
