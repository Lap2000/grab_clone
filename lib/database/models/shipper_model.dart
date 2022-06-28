import 'dart:convert';

class ShipperModel {
  final String id;
  String name;
  String phone;
  double? lat;
  double? lng;
  ShipperModel({
    required this.lat,
    required this.lng,
    required this.id,
    required this.phone,
    required this.name,
  });

  ShipperModel copyWith({
    double? lat,
    double? lng,
    String? phone,
    String? id,
    String? name,
  }) {
    return ShipperModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'phone': phone,
    };
  }

  factory ShipperModel.fromMap(Map<String, dynamic> map) {
    return ShipperModel(
        lat: double.tryParse((map['lat'] ?? 0).toString()),
        lng: double.tryParse((map['lng'] ?? 0).toString()),
        id: map['_id'],
        name: map['name'],
        phone: map['phone']);
  }

  String toJson() => json.encode(toMap());

  factory ShipperModel.fromJson(String source) =>
      ShipperModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShipperModel(_id: $id,phone:$phone, name: $name, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipperModel &&
        other.lat == lat &&
        other.lng == lng &&
        other.id == id &&
        other.phone == phone &&
        other.name == name;
  }

  @override
  int get hashCode {
    return lat.hashCode ^
        lng.hashCode ^
        id.hashCode ^
        phone.hashCode ^
        name.hashCode;
  }
}
