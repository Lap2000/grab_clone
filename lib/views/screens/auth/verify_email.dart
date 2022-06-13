import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/auth_services.dart';

import '../../widgets/custom_button1.dart';
import '../../widgets/custom_text.dart';

class VerifyEmailScreen extends StatelessWidget {
  final email;
  VerifyEmailScreen({Key? key, required this.email}) : super(key: key);
  final verifyFormKey = GlobalKey<FormState>();

  late TextEditingController otpController = TextEditingController();

  String? validateNull(String value) {
    if (value == '') {
      return "Không để trống !";
    } else {
      return null;
    }
  }

  doSend(BuildContext context) async {
    bool isValidate = verifyFormKey.currentState!.validate();
    if (isValidate) {
      var res =
          await AuthServices.verifyEmail(email: email, otp: otpController.text);
      if (res.statusCode == 200) {
        var stringOject = jsonDecode(res.body)['message'];
        print(stringOject);
        Get.back(result: true);
      } else {
        var stringOject = jsonDecode(res.body)['message'];
        Get.snackbar(
          "Verify Email",
          "Có lỗi xảy ra ! Kiểm tra lại OTP.",
          titleText: const Text(
            'Verify Email',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Có lỗi xảy ra ! Kiểm tra lại OTP.',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Form(
          key: verifyFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Verify Email,',
                      fontsize: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomText(
                  text: email,
                  alignment: Alignment.center,
                  color: Colors.black26,
                  fontsize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.network(
                  'https://img.freepik.com/free-vector/email-verification-with-validation-icon-with-check-mark-flat-design_614220-66.jpg?w=2000',
                  width: 350,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: otpController,
                  validator: (value) {
                    return validateNull(value!);
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    labelStyle: const TextStyle(
                      fontFamily: 'Comfortaa',
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.white24, width: 0.1),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.numbers),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Send',
                  color: Colors.orangeAccent,
                  onPress: () {
                    doSend(context);
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
