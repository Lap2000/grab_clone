import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grab_clone/bindings/enterprise_role_binding.dart';
import 'package:grab_clone/database/services/auth_services.dart';
import 'package:grab_clone/views/screens/dashboard/enterprise_role/enterprise_info_screen.dart';

import '../../bindings/shipper_info_binding.dart';
import '../../routes/route.dart';
import '../../views/screens/dashboard/shipper_role/shipper_info_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();

  late TextEditingController userName_controller, userPwd_controller;
  String userName = '', userPwd = '';
  var _googleSignIn = GoogleSignIn();
  Rx<GoogleSignInAccount?> googleAccount = Rx<GoogleSignInAccount?>(null);

  void _handleCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case 'back':
        Get.back();
    }
  }

  @override
  void onInit() {
    userName_controller = TextEditingController();
    userPwd_controller = TextEditingController();
    AlanVoice.addButton(
        "8c0385a687600ad41ee4f8a31cc06bf92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
    _determinePosition();
    super.onInit();
  }

  @override
  void Dispose() {
    userName_controller.dispose();
    userPwd_controller.dispose();
    super.dispose();
  }

  String? validateNull(String value) {
    if (value == '') {
      return "Không để trống !";
    } else {
      return null;
    }
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
    final _location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'User_lat', value: _location.latitude.toString());
    await storage.write(key: 'User_lng', value: _location.longitude.toString());
    return await Geolocator.getCurrentPosition();
  }

  doLogin() async {
    bool isValidate = loginFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        var data = await AuthServices.login(
            userName: userName_controller.text,
            userPwd: userPwd_controller.text);
        if (data['data'] != null) {
          //await storage.write(key: "name", value: data);
          loginFormKey.currentState!.save();
          const storage = FlutterSecureStorage();
          await storage.write(key: 'token', value: data['data']['token']);
          // String? value = await storage.read(key: 'token');
          // print('Đây là token : $value');
          if (data['data']['role'] == 0) {
            Get.toNamed(AppRoutes.dashboard);
            Get.snackbar(
              "Login",
              "Đăng nhập thành công !",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Đăng nhập thành công!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          } else if (data['data']['role'] == 2) {
            Get.to(
              () => EnterpriseInfoScreen(),
              binding: EnterpriseInfoBinding(),
            );
            Get.snackbar(
              "Login",
              "Đăng nhập thành công !",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Đăng nhập thành công!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          } else if (data['data']['role'] == 3) {
            Get.to(
              () => ShipperInfoScreen(),
              binding: ShipperInfoBinding(),
            );
            Get.snackbar(
              "Login",
              "Đăng nhập thành công !",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Đăng nhập thành công!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          } else {
            Get.snackbar(
              "Login",
              "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              messageText: Text(
                data['message'],
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          }
        } else {
          Get.snackbar(
            "Login",
            "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
            titleText: const Text(
              'Login',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            messageText: const Text(
              'Có lỗi xảy ra ! Hãy kiểm tra lại thông tin đăng nhập',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }

  doLoginWithGoogle() async {
    googleAccount.value = await _googleSignIn.signIn();
    if (googleAccount.value != null) {
      try {
        var data = await AuthServices.login(
            userName: googleAccount.value?.email,
            userPwd: '123456789${googleAccount.value?.email}');
        if (data['message'] != 'Sai tài khoản hoặc email đăng nhập!') {
          //await storage.write(key: "name", value: data);
          loginFormKey.currentState!.save();
          const storage = FlutterSecureStorage();
          await storage.write(key: 'token', value: data['data']['token']);
          // String? value = await storage.read(key: 'token');
          // print('Đây là token : $value');
          if (data['data']['role'] == 0) {
            googleAccount.value = await _googleSignIn.signOut();
            Get.toNamed(AppRoutes.dashboard);
            Get.snackbar(
              "Login",
              "Đăng nhập thành công !",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Đăng nhập thành công!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          } else if (data['data']['role'] == 2) {
            googleAccount.value = await _googleSignIn.signOut();
            Get.to(
              () => EnterpriseInfoScreen(),
              binding: EnterpriseInfoBinding(),
            );
            Get.snackbar(
              "Login",
              "Đăng nhập thành công !",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              messageText: const Text(
                'Đăng nhập thành công!',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          } else {
            Get.snackbar(
              "Login",
              "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
              titleText: const Text(
                'Login',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              messageText: Text(
                data['message'],
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            );
          }
        } else {
          try {
            var data = await AuthServices.register2(
                name: googleAccount.value?.displayName,
                userName: googleAccount.value?.email,
                email: googleAccount.value?.email,
                userPwd: '123456789${googleAccount.value?.email}');
            if (data != null) {
              var data = await AuthServices.login(
                  userName: googleAccount.value?.email,
                  userPwd: '123456789${googleAccount.value?.email}');
              if (data['data'] != null) {
                //await storage.write(key: "name", value: data);
                loginFormKey.currentState!.save();
                const storage = FlutterSecureStorage();
                await storage.write(key: 'token', value: data['data']['token']);
                // String? value = await storage.read(key: 'token');
                // print('Đây là token : $value');
                if (data['data']['role'] == 0) {
                  googleAccount.value = await _googleSignIn.signOut();
                  isLoading(false);
                  Get.toNamed(AppRoutes.dashboard);
                  Get.snackbar(
                    "Login",
                    "Đăng nhập thành công !",
                    titleText: const Text(
                      'Login',
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    messageText: const Text(
                      'Đăng nhập thành công!',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  );
                } else if (data['data']['role'] == 2) {
                  googleAccount.value = await _googleSignIn.signOut();
                  Get.to(
                    () => EnterpriseInfoScreen(),
                    binding: EnterpriseInfoBinding(),
                  );
                  Get.snackbar(
                    "Login",
                    "Đăng nhập thành công !",
                    titleText: const Text(
                      'Login',
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    messageText: const Text(
                      'Đăng nhập thành công!',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  );
                } else {
                  Get.snackbar(
                    "Login",
                    "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
                    titleText: const Text(
                      'Login',
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                    messageText: Text(
                      data['message'],
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  );
                }
              }
            } else {
              googleAccount.value = await _googleSignIn.signOut();
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
          } finally {}
        }
      } finally {}
    }
  }
}
