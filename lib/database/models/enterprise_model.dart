import 'dart:convert';

class EnterpriseModel {
  final String id;
  final String phone;
  final String name;

  EnterpriseModel({required this.id, required this.phone, required this.name});

  EnterpriseModel copyWith({
    String? id,
    String? phone,
    String? name,
  }) {
    return EnterpriseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'phone': phone,
      'name': name,
    };
  }

  factory EnterpriseModel.fromMap(Map<String, dynamic> map) {
    return EnterpriseModel(
      id: map['_id'],
      phone: map['phone'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseModel.fromJson(String source) =>
      EnterpriseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnterpriseModel(_id: $id,uID: $phone name: $name)';
  }
}
