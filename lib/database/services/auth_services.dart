import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthServices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  static register(
      {required name,
      required userName,
      required email,
      required userPwd,
      required confirmPassword}) async {
    final url = Uri.parse(baseApi + 'user/register');
    var response = await client.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        "name": name,
        "email": email,
        "userName": userName,
        "userPwd": userPwd,
        "confirmPassword": confirmPassword
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      var stringOject = response.body;
      return stringOject;
    } else if (response.body == 'Đăng ký thành công') {
      print('true');
    } else {
      print('rest api fail! + ' + response.statusCode.toString());
      return null;
    }
  }

  static login({required userName, required userPwd}) async {
    final url = Uri.parse(baseApi + 'user/login');
    print('login');
    var response = await client.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        "userName": userName,
        "userPwd": userPwd,
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      var stringOject = jsonDecode(res);
      return stringOject;
    } else {
      var stringOject1 = jsonDecode(res);
      print(stringOject1['message']);
      return stringOject1;
    }
  }

  static verifyEmail({required email, required otp}) async {
    final url = Uri.parse(baseApi + 'user/confirmUnlock');
    var response = await client.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        "email": email,
        "otp": otp,
      },
    );
    var res = response.body;
    return response;
    // print(res);
    // if (response.statusCode == 200) {
    //   var stringOject = jsonDecode(res);
    //   return stringOject;
    // } else {
    //   var stringOject1 = jsonDecode(res);
    //   print(stringOject1['message']);
    //   return stringOject1;
    // }
  }

  static forgotPassword({required email}) async {
    final url = Uri.parse(baseApi + 'user/forgotPassword?email=' + email);
    var response = await client.get(
      url,
      headers: {'Accept': 'application/json'},
    );
    var res = response.body;
    return response;
    // print(res);
    // if (response.statusCode == 200) {
    //   var stringOject = jsonDecode(res);
    //   return stringOject;
    // } else {
    //   var stringOject1 = jsonDecode(res);
    //   print(stringOject1['message']);
    //   return stringOject1;
    // }
  }

  static resetPassword({
    required email,
    required password,
    required confirmPassword,
    required otp,
  }) async {
    final url = Uri.parse(baseApi + 'user/resetPassword');
    var response = await client.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'otp': otp
      },
    );
    var res = response.body;
    return response;
  }
}
