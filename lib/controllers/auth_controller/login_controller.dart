


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/auth_services.dart';

import '../../routes/route.dart';

class LoginController extends GetxController {

  var isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();

  late TextEditingController userName_controller, userPwd_controller;
  String userName = '',
      userPwd = '';

  @override
  void onInit() {
    userName_controller = TextEditingController();
    userPwd_controller = TextEditingController();
    _determinePosition();
    super.onInit();
  }

  @override
  void Dispose() {
    userName_controller.dispose();
    userPwd_controller.dispose();
    super.dispose();
  }


  //Request Get Device's Location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final _location  = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'User_lat', value: _location.latitude.toString());
    await storage.write(key: 'User_lng', value: _location.longitude.toString());
    return await Geolocator.getCurrentPosition();
  }

  doLogin() async {
    bool isValidate = loginFormKey.currentState!.validate();
    if(isValidate){
      isLoading(true);
      try {
        var data = await AuthServices.login(userName: userName_controller.text, userPwd: userPwd_controller.text);
        if(data!= null) {
          //await storage.write(key: "name", value: data);
          loginFormKey.currentState!.save();

          final storage = new FlutterSecureStorage();
          await storage.write(key: 'token', value: data);
          String? value = await storage.read(key: 'token');
          print('Đây là token : $value');

          Get.toNamed(AppRoutes.dashboard);
          Get.snackbar("Login", "Đăng nhập thành công !",
            titleText: Text('Login',style: TextStyle(color: Colors.green,fontSize: 25),),
            messageText: Text('Đăng nhập thành công!',style: TextStyle(color: Colors.black,fontSize: 15),),
          );
        } else {
          Get.snackbar("Login", "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
            titleText: Text('Login',style: TextStyle(color: Colors.red,fontSize: 25),),
            messageText: Text('Có lỗi xảy ra ! Hãy kiểm tra lại thông tin!',style: TextStyle(color: Colors.black,fontSize: 15),),
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }

}