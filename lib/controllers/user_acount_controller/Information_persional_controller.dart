import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/account_services.dart';

class InformationController extends GetxController {
  final infoFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  //Controller sử dụng
  late TextEditingController controllerName;

  late TextEditingController controllerEmail;
  late TextEditingController controllerPhone;

  late TextEditingController controllerGender;

  late TextEditingController controllerDateofBirth;

  //final controllerLocation = TextEditingController();

  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final userName = ''.obs;
  int gender = 1;

  //final ;
  final genderSelected = 'Male'.obs;

  //String genderString ='Male';
  final dateOfBirth = DateTime.now().obs;

  @override
  void onInit() {
    controllerEmail = TextEditingController();
    controllerName = TextEditingController();
    controllerPhone = TextEditingController();
    controllerGender = TextEditingController();
    controllerDateofBirth = TextEditingController();
    doGetUserInfo();
    super.onInit();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerName.dispose();
    controllerPhone.dispose();
    controllerGender.dispose();
    controllerDateofBirth.dispose();
    super.dispose();
  }

  String? validateNull(String value) {
    if (value == '') {
      return "Empty !";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (value == '') {
      return "Empty !";
    } else if (!value.isNum) {
      return "Your phone number is in the wrong format !";
    } else if (value.length <= 9) {
      return "Your phone number is too short !";
    } else {
      return null;
    }
  }

  void setSelected(var value) {
    genderSelected.value = value;
    if (genderSelected.value == "Male") {
      gender = 0;
    } else
      gender = 1;
    print(gender);
  }

  //Khởi tạo bộ lịch
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateOfBirth.value,
        firstDate: DateTime(1975, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != dateOfBirth.value) {
      dateOfBirth.value = picked;
    }
    ;
  }

  Future<void> doGetUserInfo() async {
    //bool isValidate = infoFormKey.currentState!.validate();

    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    //print('Đây là token : $value');
    try {
      var data = await Accountservices.getUserInfo(token: value);
      if (data != null) {
        var res = jsonDecode(data);
        //userName = res['userName'];
        name.value = res['data']['name'];
        controllerName.text = name.value;
        userName.value = res['data']['userName'];
        email.value = res['data']['email'];
        controllerEmail.text = email.value;
        phone.value = res['data']['phone'];
        controllerPhone.text = phone.value;
        dateOfBirth.value = DateTime.tryParse(res['data']['dateofBirth'])!;
        gender = res['data']['gender'];
        if (gender == 0) {
          genderSelected.value = 'Male';
        } else
          genderSelected.value = 'Female';
        print(name.value);
        // print(res.runtimeType);
        //infoFormKey.currentState!.save();
        Get.snackbar(
          "UserInfo",
          "Success Loading !",
          titleText: Text(
            'UserInfo',
            style: TextStyle(color: Colors.green, fontSize: 25),
          ),
          messageText: Text(
            'Success Loading !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      } else {
        Get.snackbar(
          "UserInfo",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
        );
      }
    } finally {
      update();
    }
  }

  doChangeInfo() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    bool isValidate = infoFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        var data = await Accountservices.changeInfo(
          name: controllerName.text,
          email: email.value,
          phone: controllerPhone.text,
          gender: gender.toString(),
          dateofBirth: dateOfBirth.toString(),
          token: value,
        );
        if (data != null) {
          //await storage.write(key: "name", value: data);
          infoFormKey.currentState!.save();
          Get.back();
          Get.snackbar(
            "ChangeInfo",
            "Có lỗi xảy ra ! Kiểm tra lại thông tin.()",
            titleText: const Text(
              'UserInfo',
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            messageText: const Text(
              'Đổi thông tin thành công!',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        } else {
          Get.snackbar(
            "ChangeInfo",
            "Có lỗi xảy ra ! Kiểm tra lại thông tin.()",
            titleText: const Text(
              'UserInfo',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: const Text(
              'Có lỗi xảy ra ! Kiểm tra lại thông tin.()',
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
