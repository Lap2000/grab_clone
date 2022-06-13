import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/auth_controller/forgot_password_controller.dart';

import '../../widgets/custom_button1.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textformfield.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: controller.forgotFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Forgot Password,',
                      fontsize: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Image.network(
                  'https://stories.freepiklabs.com/storage/19513/forgot-password-amico-1951.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLines: null,
                        controller: controller.emailController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            fontFamily: 'Comfortaa',
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white24, width: 0.1),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 60,
                      child: Obx(
                        () => CustomButton(
                          text: controller.isSendOTP.value == true
                              ? controller.timeCounter.value.toString()
                              : 'Gửi OTP',
                          color: controller.isSendOTP.value == true
                              ? Colors.grey
                              : Colors.orangeAccent,
                          onPress: () {
                            controller.onSendOTP();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: controller.newPwdController,
                  passCheck: true,
                  text: 'New Password',
                  hint: '*********',
                  onSave: (value) {},
                  validator: (value) {
                    return controller.validatePassword(value!);
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: controller.confirmPwdController,
                  passCheck: true,
                  text: 'ConfirmPassword',
                  hint: '*********',
                  onSave: (value) {},
                  validator: (value) {
                    return controller.validateConfirmPassword(value!);
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: controller.otpController,
                  passCheck: false,
                  text: 'OTP',
                  hint: '678977',
                  onSave: (value) {},
                  validator: (value) {
                    return controller.validateOTP(value!);
                  },
                ),
                const SizedBox(height: 25),
                Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(),
                ),
                CustomButton(
                  text: 'Xác nhận',
                  color: Colors.orangeAccent,
                  onPress: () {
                    controller.onResetPassword();
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
