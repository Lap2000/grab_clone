import 'dart:convert';

import 'package:grab_clone/database/models/comment/comment_model.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductServices {
  static String baseApi = 'https://findwhere-app.herokuapp.com/';
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
}
