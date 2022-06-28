import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String E_id;
  String name;
  String description;
  List<String> Types;
  double? price;
  List<String> imagesProduct;
  double? star;
  bool isOutStock;
  ProductModel({
    required this.Types,
    required this.imagesProduct,
    required this.price,
    required this.star,
    required this.E_id,
    required this.id,
    required this.description,
    required this.isOutStock,
    required this.name,
  });

  ProductModel copyWith({
    List<String>? Types,
    List<String>? imagesProduct,
    double? price,
    double? star,
    String? E_id,
    String? description,
    String? id,
    String? name,
    bool? isOutStock,
  }) {
    return ProductModel(
      Types: Types ?? this.Types,
      imagesProduct: imagesProduct ?? this.imagesProduct,
      price: price ?? this.price,
      star: star ?? this.star,
      E_id: E_id ?? this.E_id,
      id: id ?? this.id,
      name: name ?? this.name,
      isOutStock: isOutStock ?? this.isOutStock,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'eID': E_id,
      'name': name,
      'images': imagesProduct,
      'price': price,
      'score': star,
      'types': Types,
      'description': description,
      'isOutStock': isOutStock,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        Types:
            (map['types'] as List<dynamic>).map((e) => e.toString()).toList(),
        price: double.tryParse((map['price'] ?? 0).toString()),
        star: double.tryParse((map['score'] ?? 0).toString()),
        imagesProduct:
            (map['images'] as List<dynamic>).map((e) => e.toString()).toList(),
        id: map['_id'],
        E_id: map['eID'],
        name: map['name'],
        isOutStock: map['isOutStock'],
        description: map['description']);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(_id: $id,isOutStock: $isOutStock,eID: $E_id,description:$description, name: $name, images: $imagesProduct, price: $price, score: $star, types: $Types)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        listEquals(other.Types, Types) &&
        other.price == price &&
        listEquals(other.imagesProduct, imagesProduct) &&
        other.star == star &&
        other.id == id &&
        other.description == description &&
        other.E_id == E_id &&
        other.isOutStock == isOutStock &&
        other.name == name;
  }

  @override
  int get hashCode {
    return Types.hashCode ^
        price.hashCode ^
        imagesProduct.hashCode ^
        star.hashCode ^
        id.hashCode ^
        E_id.hashCode ^
        description.hashCode ^
        isOutStock.hashCode ^
        name.hashCode;
  }
}
