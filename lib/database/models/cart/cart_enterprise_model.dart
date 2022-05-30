import 'dart:convert';

class CartEnterpriseModel {
  final String eID;
  final String eName;

  CartEnterpriseModel({required this.eID, required this.eName});

  CartEnterpriseModel copyWith({
    String? eID,
    String? eName,
  }) {
    return CartEnterpriseModel(
      eID: eID ?? this.eID,
      eName: eName ?? this.eName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eID': eID,
      'eName': eName,
    };
  }

  factory CartEnterpriseModel.fromMap(Map<String, dynamic> map) {
    return CartEnterpriseModel(
      eID: map['eID'],
      eName: map['eName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartEnterpriseModel.fromJson(String source) =>
      CartEnterpriseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnterpriseModel(eID: $eID,uID: $eName name: $eName)';
  }
}
