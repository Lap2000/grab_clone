import 'dart:convert';

class EnterpriseModel {
  final String id;
  final String phone;
  final String name;
  final double? lat;
  final double? lng;
  final String activeTime;

  EnterpriseModel(
      {required this.lat,
      required this.lng,
      required this.id,
      required this.phone,
      required this.activeTime,
      required this.name});

  EnterpriseModel copyWith({
    String? id,
    String? phone,
    String? name,
    String? activeTime,
    double? lat,
    double? lng,
  }) {
    return EnterpriseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      activeTime: activeTime ?? this.activeTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'phone': phone,
      'name': name,
      'lat': lat,
      'lng': lng,
      'activeTime': activeTime,
    };
  }

  factory EnterpriseModel.fromMap(Map<String, dynamic> map) {
    return EnterpriseModel(
      id: map['_id'],
      phone: map['phone'],
      name: map['name'],
      activeTime: map['activeTime'],
      lat: double.tryParse((map['lat'] ?? 0).toString()),
      lng: double.tryParse((map['lng'] ?? 0).toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseModel.fromJson(String source) =>
      EnterpriseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnterpriseModel(_id: $id,phone: $phone, name: $name,lat:$lat, lng:$lng,activeTime:$activeTime)';
  }
}
