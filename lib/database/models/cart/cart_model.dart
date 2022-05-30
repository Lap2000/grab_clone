import 'dart:convert';

class CartModel {
  final String pID;
  final String pName;
  String pImage;
  int? pAmount;
  double? pPrice;
  double? pTotal;

  CartModel(
      {required this.pID,
      required this.pName,
      required this.pAmount,
      required this.pImage,
      required this.pPrice,
      required this.pTotal});

  void addcount(int amount) {
    if (pAmount! >= 20) {
    } else {
      pAmount = pAmount! + amount;
      pTotal = pTotal! + pTotal! * amount;
    }
  }

  void subcount(int amount) {
    if (pAmount! <= amount) {
      pAmount = 0;
      pTotal = 0;
    } else {
      pAmount = pAmount! - amount;
      pTotal = pTotal! - pTotal! * amount;
    }
  }

  CartModel copyWith({
    String? pID,
    String? pName,
    String? pImage,
    int? pAmount,
    double? pPrice,
    double? pTotal,
  }) {
    return CartModel(
      pAmount: pAmount ?? this.pAmount,
      pPrice: pPrice ?? this.pPrice,
      pImage: pImage ?? this.pImage,
      pID: pID ?? this.pID,
      pName: pName ?? this.pName,
      pTotal: pTotal ?? this.pTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pID': pID,
      'pName': pName,
      'pAmount': pAmount,
      'pPrice': pPrice,
      'pTotal': pTotal,
      'pImage': pImage
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      pPrice: double.tryParse((map['pPrice'] ?? 0).toString()),
      pTotal: double.tryParse((map['pTotal'] ?? 0).toString()),
      pAmount: int.tryParse((map['pAmount'] ?? 0).toString()),
      pID: map['pID'],
      pName: map['pName'],
      pImage: map['pImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(pID: $pID,pName: $pName,pAmount:$pAmount, pPrice: $pPrice, pTotal: $pTotal,pImage: $pImage)';
  }
}
