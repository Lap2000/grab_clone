import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/auth_services.dart';
import 'package:grab_clone/routes/route.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final RegisterFormKey = GlobalKey<FormState>();

  late TextEditingController nameController,userNameController,
      emailController, userPwdController,confirmPasswordController;
  String name = '', email ='', userName = '',
        userPwd = '', confirmPassword ='';

  final storage =  const FlutterSecureStorage();

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
    if(!GetUtils.isEmail(value)) {
      return "Wrong Email !";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if(value.length <=5) {
      return "Your password is so short !";
    } else {
      return null;
    }
  }

  doRegister() async {
    bool isValidate = RegisterFormKey.currentState!.validate();
    if(isValidate) {
      isLoading(true);
      try {
        var data = await AuthServices.register(
            name: nameController.text,
            userName: userNameController.text,
            email: emailController.text,
            userPwd: userPwdController.text,
            confirmPassword: confirmPasswordController.text);
        if(data!= null) {
          //await storage.write(key: "name", value: data);
          RegisterFormKey.currentState!.save();
          Get.back();
          Get.snackbar("Register", "Đăng ký thành công, hãy đăng nhập!",
            titleText: Text('Register',style: TextStyle(color: Colors.green,fontSize: 25),),
            messageText: Text('Đăng ký thành công, hãy đăng nhập!',style: TextStyle(color: Colors.black,fontSize: 15),),
          );

        } else {
          Get.snackbar("Register", "Có lỗi xảy ra ! Kiểm tra lại thông tin.(Email - Username)",
            titleText: Text('Register',style: TextStyle(color: Colors.red,fontSize: 25),),
            messageText: Text('Có lỗi xảy ra ! Kiểm tra lại thông tin.(Email - Username)',style: TextStyle(color: Colors.black,fontSize: 15),),
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }

}