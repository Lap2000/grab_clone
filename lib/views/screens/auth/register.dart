import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/views/widgets/custom_button1.dart';
import 'package:grab_clone/views/widgets/custom_text.dart';
import 'package:grab_clone/views/widgets/custom_textformfield.dart';

import '../../../controllers/auth_controller/register_controller.dart';

class Register extends GetView<RegisterController> {
  const Register({Key? key}) : super(key: key);

  //RegisterController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Form(
          key: controller.RegisterFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: CustomText(
                        text: 'Create an account',
                        maxLines: 3,
                        fontsize: 30,
                      ),
                    ),
                    Container(
                        child: Icon(
                      Icons.key,
                      size: 40,
                    ))
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  child: CustomText(
                    text: 'Create your acount to sign in',
                    fontsize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 40),
                CustomTextFormField(
                    controller: controller.nameController,
                    text: 'Your name',
                    hint: 'Nguyen Van A',
                    onSave: (value) {
                      controller.name = value!;
                    },
                    validator: (value) {
                      controller.name = value!;
                    }),
                SizedBox(height: 15),
                CustomTextFormField(
                    controller: controller.userNameController,
                    text: 'Username',
                    hint: 'nguyenvana123',
                    onSave: (value) {
                      controller.userName = value!;
                    },
                    validator: (value) {
                      controller.userName = value!;
                    }),
                SizedBox(height: 15),
                CustomTextFormField(
                    controller: controller.emailController,
                    text: 'Your email',
                    hint: 'nguyenvana@gmail.com',
                    onSave: (value) {
                      controller.email = value!;
                    },
                    validator: (value) {
                      return controller.validateEmail(value!);
                    }),
                SizedBox(height: 15),
                CustomTextFormField(
                    controller: controller.userPwdController,
                    passCheck: true,
                    text: 'Password',
                    hint: '*********',
                    onSave: (value) {
                      controller.userPwd = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value!);
                    }),
                SizedBox(height: 15),
                CustomTextFormField(
                    controller: controller.confirmPasswordController,
                    passCheck: true,
                    text: 'ConfirmPassword',
                    hint: '*********',
                    onSave: (value) {
                      controller.confirmPassword = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value!);
                    }),
                Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(""),
                ),
                FlatButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: CustomText(
                      text: 'Already have an account? Let Sign in!',
                      alignment: Alignment.topRight,
                    )),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onPress: () {
                    controller.doRegister();
                  },
                  text: 'Sign up',
                  color: Colors.orangeAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
