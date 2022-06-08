import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  static getOrderByDate() async {
    final url = Uri.parse(baseApi + 'order/getOrderByDate');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    //print('$response');
    //print('hello  +$res');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static getNotConfirmOrderByDate() async {
    final url = Uri.parse(baseApi + 'order/getNotConfirmOrderByDate');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    //print('$response');
    //print('hello  +$res');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static getNotConfirmProductsOrder() async {
    final url = Uri.parse(baseApi + 'order/getNotConfirmProductsOrder');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    //print('$response');
    print('hello  +${jsonDecode(res)}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static getProductsOrder() async {
    final url = Uri.parse(baseApi + 'order/getProductsOrder');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    //print('$response');
    //print('hello  +$res');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static confirmOrder({required String id}) async {
    final url = Uri.parse(baseApi + 'order/confirmOrder');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $token',
      },
      body: {"oID": id},
    );
    var res = jsonDecode(response.body);
    //print('$response');
    print('hello  +$res');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
