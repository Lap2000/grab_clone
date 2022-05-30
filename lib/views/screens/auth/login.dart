import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/routes/route.dart';
import 'package:grab_clone/views/widgets/custom_button1.dart';
import 'package:grab_clone/views/widgets/custom_textformfield.dart';

import '../../../controllers/auth_controller/login_controller.dart';
import '../../widgets/custom_text.dart';

class Login extends GetView<LoginController> {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Form(
          key: controller.loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Welcome,',
                      fontsize: 30,
                    ),
                    FlatButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        child: CustomText(
                          text: 'Sign up',
                          fontsize: 18,
                          color: Colors.blueAccent,
                        ))
                  ],
                ),
                SizedBox(height: 10),
                CustomText(
                  text: 'Login to Continue !',
                  color: Colors.black26,
                  fontsize: 20,
                ),
                Image.asset(
                  'assets/images/logo2.png',
                  width: 350,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 40),
                CustomTextFormField(
                    controller: controller.userName_controller,
                    text: 'Username/Email',
                    hint: 'Username or Email - @gmail.com',
                    onSave: (value) {
                      controller.userName = value!;
                    },
                    validator: (value) {}),
                SizedBox(height: 20),
                CustomTextFormField(
                    controller: controller.userPwd_controller,
                    passCheck: true,
                    text: 'Password',
                    hint: '************',
                    onSave: (value) {
                      controller.userPwd = value!;
                    },
                    validator: (value) {}),
                SizedBox(height: 15),
                CustomText(
                  text: 'Forgot Password ?',
                  fontsize: 15,
                  alignment: Alignment.topRight,
                ),
                Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(""),
                ),
                SizedBox(height: 15),
                CustomButton(
                  text: 'Sign in',
                  color: Colors.orangeAccent,
                  onPress: () {
                    controller.doLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
