import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../../controllers/user_acount_controller/change_password_controller.dart';
import '../../../../widgets/custom_button1.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    Widget buildTextField(
        String labelText,
        String hintText,
        TextEditingController controller,
        bool visible,
        VoidCallback function,
        FormFieldValidator<String>? validator) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          obscureText: visible,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16,
            ),
            // Here is key idea
            suffixIcon: IconButton(
              icon: Icon(
                visible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: function,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black87,
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.changePasswordFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Thay đổi mật khẩu ! "
                    "Bạn hãy bảo mật cẩn thận thông tin của mình !",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Obx(
                  () => buildTextField(
                    "Mật khẩu cũ",
                    "Nhập mật khẩu cũ",
                    controller.OldPasswordontroller,
                    controller.passwordVisible.value,
                    () {
                      controller.passwordVisibleChange();
                    },
                    (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                ),
                Obx(
                  () => buildTextField(
                    "Mật khẩu mới",
                    "Nhập mật khẩu mới",
                    controller.NewPasswordController,
                    controller.passwordVisible.value,
                    () {
                      controller.passwordVisibleChange();
                    },
                    (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                ),
                Obx(
                  () => buildTextField(
                    "Xác nhận mật khẩu mới",
                    "Nhập lại mật khẩu mới",
                    controller.ConfirmPasswordController,
                    controller.passwordVisible.value,
                    () {
                      controller.passwordVisibleChange();
                    },
                    (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                ),
                Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(""),
                ),
                CustomButton(
                  onPress: () {
                    controller.doChangePassword();
                  },
                  text: 'Save',
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
