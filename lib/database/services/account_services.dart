import 'dart:convert';

import 'package:http/http.dart' as http;

class Accountservices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  static getUserInfo({required token}) async {
    final url = Uri.parse(baseApi + 'user/findUserByToken');

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static changeInfo(
      {required name,
      required email,
      required phone,
      required gender,
      required dateofBirth,
      required token}) async {
    final url = Uri.parse(baseApi + 'user/changeInfo');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $token',
      },
      body: {
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dateofBirth": dateofBirth
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var stringOject = response.body;
      return stringOject;
    } else {
      print('rest api fail! + ' + response.statusCode.toString());
      //print(response.body);
      return null;
    }
  }

  static changePassword({
    required token,
    required oldPass,
    required newPass,
    required confirmPass,
  }) async {
    final url = Uri.parse(baseApi + 'user/changePassword');

    var response = await client.post(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    }, body: {
      'oldPassword': oldPass,
      'newPassword': newPass,
      'confirmPassword': confirmPass,
    });
    var res = jsonDecode(response.body)['message'];
    print(res);
    if (response.statusCode == 200) {
      return res;
    } else {
      print(response.statusCode);
      return res;
    }
  }
}
