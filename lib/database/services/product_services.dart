import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grab_clone/database/models/comment/comment_model.dart';
import 'package:grab_clone/database/models/enterprise_model.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductServices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
  //static String baseApi = 'http://192.168.1.7:5000/';
  static var client = http.Client();

  static Future<List<ProductModel>> getFindProductList(
      {required productName}) async {
    final url =
        Uri.parse(baseApi + 'product/findProductByName?name=' + productName);

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ProductModel.fromMap(item)).toList();
    }
    return [];
  }

  static Future<List<ProductModel>> getProductListOfEnterprise(
      {required id}) async {
    final url =
        Uri.parse(baseApi + 'product/getProductOfEnterpriseSort?id=' + id);

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse =
          jsonDecode(response.body)['data']['data']['products'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ProductModel.fromMap(item)).toList();
    }
    return [];
  }

  static Future<EnterpriseModel?> getEnterPrise({required id}) async {
    final url = Uri.parse(baseApi + 'user/getEnterpriseById?id=' + id);

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return null;
      }
      return EnterpriseModel.fromMap(jsonResponse);
    }
    return null;
  }

  static addUsersHistory(
      {required pID, required pName, required pPrice, required pImage}) async {
    final url = Uri.parse(baseApi + 'user/addSearchHistory');
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    print(value);
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $value',
      },
      body: {
        "pID": pID,
        "pName": pName,
        "pPrice": pPrice.toString(),
        "pImage": pImage
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static Future<List<ProductModel>> getProductListByType(
      {required String type}) async {
    final url = Uri.parse(baseApi + 'product/findProductByType?types=$type');

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ProductModel.fromMap(item)).toList();
    }
    return [];
  }

  static Future<List<ProductModel>> getAllProductList() async {
    final url = Uri.parse(baseApi + 'product/getALLProduct');

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ProductModel.fromMap(item)).toList();
    }
    return [];
  }

  static Future<dynamic> getEnterpriseOfProduct({required Eid}) async {
    final url = Uri.parse(baseApi + 'user/getEnterpriseById?id=' + Eid);

    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  static Future<List<CommentModel>> getCommentList({required idProduct}) async {
    final url =
        Uri.parse(baseApi + 'evaluate/getEvaluateOfProduct?pID=' + idProduct);
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => CommentModel.fromMap(item)).toList();
    }
    return [];
  }

  static Future<List<ProductModel>> getEnterpriseProductList() async {
    final url = Uri.parse(baseApi + 'product/getEnterpriseProductSort');
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await client.get(url, headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": 'Basic $token',
    });
    //var res = response.body;
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse =
          jsonDecode(response.body)['data']['data']['products'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ProductModel.fromMap(item)).toList();
    }
    return [];
  }

  static addEvaluate({required pID, required score, required comment}) async {
    final url = Uri.parse(baseApi + 'evaluate/addEvaluate');
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    print(value);
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $value',
      },
      body: {
        "pID": pID,
        "score": score.toString(),
        "comment": comment,
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static getUserEvaluate({required pID}) async {
    final url = Uri.parse(baseApi + 'evaluate/getUserEvaluate?pID=' + pID);
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    print(value);
    var response = await client.get(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $value',
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static editEvaluate({required pID, required score, required comment}) async {
    final url = Uri.parse(baseApi + 'evaluate/editEvaluate');
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    print(value);
    var response = await client.post(
      url,
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
        "Authorization": 'Basic $value',
      },
      body: {
        "pID": pID,
        "score": score.toString(),
        "comment": comment,
      },
    );
    var res = response.body;
    print(res);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
