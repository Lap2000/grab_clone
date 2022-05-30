import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Cartservices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  static getCart() async {
    final url = Uri.parse(baseApi + 'cart/getCart');
    final storage = new FlutterSecureStorage();
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
      var v1 = jsonResponse['data']['ListEnterpriseID'];
      //print('$v1');
      //print(v1.runtimeType);
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static getCartByEnterprise({required eid}) async {
    final url = Uri.parse(baseApi + 'cart/getCartByEnterprise?eID=$eid');
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
      var v1 = jsonResponse['data'];
      //print('$v1');
      //print(v1.runtimeType);
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static deleteCartByEnterprise({required eid}) async {
    final url = Uri.parse(baseApi + 'cart/deleteEnterpirseProductInCart');
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
        "eID": eid,
      },
    );
    var res = response.body;
    print('$response');
    //print('hello  +$res');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static AddProductIntoCart(
      {required pID,
      required pName,
      required pAmount,
      required pPrice,
      required pImage}) async {
    final url = Uri.parse(baseApi + 'cart/addProductIntoCart');
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $token',
      },
      body: {
        "pID": pID,
        "pName": pName,
        "pAmount": pAmount,
        "pPrice": pPrice,
        "pImage": pImage
      },
    );
    //print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var stringOject = response.body;
      return stringOject;
    } else {
      print('rest api fail! + ' + response.statusCode.toString());
      //print(response.body);
      return null;
    }
  }

  static EditProductInCart({required pID, required pAmount}) async {
    print(pAmount);
    final url = Uri.parse(baseApi + 'cart/editProductInCart');
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $token',
      },
      body: {
        "pID": pID,
        "pAmount": pAmount.toString(),
      },
    );
    //print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var stringOject = response.body;
      return stringOject;
    } else {
      print('rest api fail! + ' + response.statusCode.toString());
      //print(response.body);
      return null;
    }
  }

  static deleteProductFromCart({
    required pID,
  }) async {
    final url = Uri.parse(baseApi + 'cart/deleteProductInCart');
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.post(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    }, body: {
      'pID': pID,
    });
    var res = jsonDecode(response.body)['message'];
    //print(res);
    if (response.statusCode == 200) {
      return res;
    } else {
      print(response.statusCode);
      return res;
    }
  }
}
