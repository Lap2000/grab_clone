import 'dart:convert';

import '../cart/cart_model.dart';

class OrderModel {
  final String id;
  final String userID;
  String phone;
  String name;
  String location;
  List<CartModel> orderDetail;
  double? lat;
  double? lng;
  String enterpriseID;
  String enterpriseName;
  String? shipperID;
  String? shipperName;
  int? discount;
  int? totalPrice;
  int? shipCost;
  int status;
  bool isOnlinePayment;
  DateTime orderDate;
  OrderModel({
    required this.orderDetail,
    required this.lat,
    required this.lng,
    required this.userID,
    required this.phone,
    required this.location,
    required this.name,
    required this.enterpriseID,
    required this.enterpriseName,
    required this.shipperID,
    required this.shipperName,
    required this.discount,
    required this.totalPrice,
    required this.shipCost,
    required this.status,
    required this.isOnlinePayment,
    required this.orderDate,
    required this.id,
  });

  OrderModel copyWith({
    List<CartModel>? orderDetail,
    double? lat,
    double? lng,
    String? userID,
    String? phone,
    String? location,
    String? id,
    String? name,
    String? enterpriseID,
    String? enterpriseName,
    String? shipperID,
    String? shipperName,
    int? discount,
    int? totalPrice,
    int? shipCost,
    int? status,
    bool? isOnlinePayment,
    DateTime? orderDate,
  }) {
    return OrderModel(
      orderDetail: orderDetail ?? this.orderDetail,
      userID: userID ?? this.userID,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      id: id ?? this.id,
      name: name ?? this.name,
      enterpriseID: enterpriseID ?? this.enterpriseID,
      enterpriseName: enterpriseName ?? this.enterpriseName,
      shipperID: shipperID ?? this.shipperID,
      shipperName: shipperName ?? this.shipperName,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      shipCost: shipCost ?? this.shipCost,
      status: status ?? this.status,
      isOnlinePayment: isOnlinePayment ?? this.isOnlinePayment,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userID': userID,
      'name': name,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'orderDetail': orderDetail,
      'location': location,
      'enterpriseID': enterpriseID,
      'enterpriseName': enterpriseName,
      'shipperID': shipperID,
      'shipperName': shipperName,
      'discount': discount,
      'totalPrice': totalPrice,
      'shipCost': shipCost,
      'status': status,
      'orderDate': orderDate,
      'isOnlinePayment': isOnlinePayment,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderDetail: (map['orderDetail'] as List<dynamic>)
          .map((item) => CartModel.fromMap(item))
          .toList(),
      lat: double.tryParse((map['lat'] ?? 0).toString()),
      lng: double.tryParse((map['lng'] ?? 0).toString()),
      id: map['_id'],
      userID: map['userID'],
      name: map['name'],
      phone: map['phone'],
      location: map['location'],
      enterpriseID: map['enterpriseID'],
      enterpriseName: map['enterpriseName'],
      shipperID: map['shipperID'],
      shipperName: map['shipperName'],
      discount: map['discount'],
      totalPrice: map['totalPrice'],
      shipCost: map['shipCost'],
      status: map['status'],
      isOnlinePayment: map['isOnlinePayment'],
      orderDate: DateTime.parse(map['orderDate'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(_id: $id,userID: $userID,phone:$phone, name: $name, location: $location, lat: $lat, lng: $lng, orderDetail: $orderDetail, enterpriseID: $enterpriseID, enterpriseName: $enterpriseName, shipperID: $shipperID, shipperName: $shipperName, discount: $discount, totalPrice: $totalPrice,shipCost:$shipCost, status: $status,isOnlinePayment:$isOnlinePayment, orderDate: $orderDate)';
  }
}
