import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/order_user/order_model.dart';

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

  // static Stream<List<OrderModel>> getOrderByDateFlow() async* {
  //   yield* Stream.periodic(Duration(seconds: 3), (_) {
  //     return getOrderByDate();
  //   }).asyncMap((event) async => await event);
  // }
  //
  // static Future<List<OrderModel>> getOrderByDate() async {
  //   final url = Uri.parse(baseApi + 'order/getOrderByDate');
  //   final storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'token');
  //   var response = await client.get(url, headers: {
  //     "Content-type": "application/x-www-form-urlencoded",
  //     "Accept": "application/json",
  //     "Authorization": 'Basic $token',
  //   });
  //   var res = response.body;
  //   //print('$response');
  //   //print('hello  +$res');
  //   if (response.statusCode == 200) {
  //     //var jsonResponse = jsonDecode(response.body)['data'];
  //     List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
  //     List<OrderModel> orderConfirmList =
  //         jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
  //     return orderConfirmList;
  //   } else {
  //     print(response.statusCode);
  //     return [];
  //   }
  // }

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

  // static Stream<List<OrderModel>> getNotConfirmOrderByDateFlow() async* {
  //   yield* Stream.periodic(Duration(seconds: 3), (_) {
  //     return getNotConfirmOrderByDate();
  //   }).asyncMap((event) async => await event);
  // }
  //
  // static Future<List<OrderModel>> getNotConfirmOrderByDate() async {
  //   final url = Uri.parse(baseApi + 'order/getNotConfirmOrderByDate');
  //   final storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'token');
  //   var response = await client.get(url, headers: {
  //     "Content-type": "application/x-www-form-urlencoded",
  //     "Accept": "application/json",
  //     "Authorization": 'Basic $token',
  //   });
  //   var res = response.body;
  //   //print('$response');
  //   //print('hello  +$res');
  //   if (response.statusCode == 200) {
  //     //var jsonResponse = jsonDecode(response.body)['data'];
  //     List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
  //     List<OrderModel> orderConfirmList =
  //         jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
  //     return orderConfirmList;
  //   } else {
  //     print(response.statusCode);
  //     return [];
  //   }
  // }

  // static Stream<List<OrderModel>> GetUserOnTheWayOrderFlow() async* {
  //   yield* Stream.periodic(Duration(seconds: 3), (_) {
  //     return GetUserOnTheWayOrder();
  //   }).asyncMap((event) async => await event);
  // }
  //
  // static Future<List<OrderModel>> GetUserOnTheWayOrder() async {
  //   final url = Uri.parse(baseApi + 'order/GetUserOnTheWayOrder');
  //   final storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'token');
  //   var response = await client.get(url, headers: {
  //     "Content-type": "application/x-www-form-urlencoded",
  //     "Accept": "application/json",
  //     "Authorization": 'Basic $token',
  //   });
  //   var res = response.body;
  //   //print('$response');
  //   //print('hello  +$res');
  //   if (response.statusCode == 200) {
  //     //var jsonResponse = jsonDecode(response.body)['data'];
  //     List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
  //     List<OrderModel> orderConfirmList =
  //         jsonResponse.map((item) => OrderModel.fromMap(item)).toList();
  //     return orderConfirmList;
  //   } else {
  //     print(response.statusCode);
  //     return [];
  //   }
  // }

  static GetUserOnTheWayOrder() async {
    final url = Uri.parse(baseApi + 'order/GetUserOnTheWayOrder');
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

  static Stream<List<OrderModel>> getNotConfirmProductsOrderFlow() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) {
      return getNotConfirmProductsOrder();
    }).asyncMap((event) async => await event);
  }

  static Future<List<OrderModel>> getNotConfirmProductsOrder() async {
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

  // static getNotConfirmProductsOrder() async {
  //   final url = Uri.parse(baseApi + 'order/getNotConfirmProductsOrder');
  //   final storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'token');
  //   var response = await client.get(url, headers: {
  //     "Content-type": "application/x-www-form-urlencoded",
  //     "Accept": "application/json",
  //     "Authorization": 'Basic $token',
  //   });
  //   var res = response.body;
  //   //print('$response');
  //   //print('hello  +${jsonDecode(res)}');
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body)['data'];
  //     return response.body;
  //   } else {
  //     print(response.statusCode);
  //     return null;
  //   }
  // }

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
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static confirmShipperOrder({required String id}) async {
    final url = Uri.parse(baseApi + 'order/confirmShipperOrder');
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
      },
    );
    var res = jsonDecode(response.body);
    //print('$response');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static paymentConfirm({required String id}) async {
    final url = Uri.parse(baseApi + 'order/paymentConfirm');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      },
      body: {
        "id": id,
      },
    );
    var res = jsonDecode(response.body);
    //print('$response');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static Stream<dynamic> getOrderByIdFlow({required id}) async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) {
      return getOrderById(id: id);
    }).asyncMap((event) async => await event);
  }

  static Future<dynamic> getOrderById({required id}) async {
    final url = Uri.parse(baseApi + 'order/getOrderById?oID=' + id);
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    var res = response.body;
    if (response.statusCode == 200) {
      //var jsonResponse = jsonDecode(response.body)['data'];
      var jsonResponse = jsonDecode(response.body)['data'];
      //OrderModel orderConfirmList = OrderModel.fromMap(jsonResponse);
      return jsonResponse;
    } else {
      print(response.statusCode);
      return null;
      // OrderModel(
      //   shipCost: null,
      //   isOnlinePayment: false,
      //   id: '',
      //   status: 0,
      //   shipperName: '',
      //   enterpriseID: '',
      //   userID: '',
      //   shipperID: '',
      //   discount: null,
      //   orderDate: DateTime.now(),
      //   enterpriseName: '',
      //   name: '',
      //   lng: null,
      //   phone: '',
      //   orderDetail: [],
      //   location: '',
      //   totalPrice: null,
      //   lat: null);
    }
  }
}
