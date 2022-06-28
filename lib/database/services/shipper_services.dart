import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grab_clone/database/models/shipper_model.dart';
import 'package:http/http.dart' as http;

import '../models/order_user/order_model.dart';

class ShipperServices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  // static Stream<List<ShipperModel>> getShipperAround2Flow() {
  //   return Stream.fromFuture(getShipperAround2());
  // }

  static Stream<List<ShipperModel>> getShipperAround2Flow() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) {
      return getShipperAround2();
    }).asyncMap((event) async => await event);
  }

  static Future<List<ShipperModel>> getShipperAround2() async {
    final url = Uri.parse(baseApi + 'user/getShipperAround');
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
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ShipperModel.fromMap(item)).toList();
    }
    return [];
  }

  static getShipperConfirmOrder() async {
    final url = Uri.parse(baseApi + 'order/getShipperConfirmOrder');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    //print('$response');
    //print('hello  +${jsonDecode(res)}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static Stream<List<OrderModel>> getShipperOrderFlow() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) {
      return getShipperOrder();
    }).asyncMap((event) async => await event);
  }

  static Future<List<OrderModel>> getShipperOrder() async {
    final url = Uri.parse(baseApi + 'order/getShipperOrder');
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
      //var jsonResponse = jsonDecode(response.body)['data'];
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      List<OrderModel> orderConfirmList =
          jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
      return orderConfirmList;
    } else {
      print(response.statusCode);
      return [];
    }
  }

  static confirmOrder(
      {required String id, required shipperID, required shipperName}) async {
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
      body: {
        "oID": id,
        "shipperID": shipperID,
        "shipperName": shipperName,
      },
    );
    var res = jsonDecode(response.body);
    //print('$response');
    if (response.statusCode == 200) {
      //var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static uploadUserLocation({
    required lat,
    required lng,
  }) async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(baseApi + 'user/uploadUserLocation');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $token',
      },
      body: {
        "lat": lat.toString(),
        "lng": lng.toString(),
      },
    );
    //print(response.body);
    if (response.statusCode == 200) {
      var stringOject = response.body;
      return stringOject;
    } else {
      print('rest api fail! + ' + response.statusCode.toString());
      //print(response.body);
      return null;
    }
  }
}
