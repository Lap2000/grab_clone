import 'package:grab_clone/database/models/product_model.dart';

class Distances {
  final String pID;
  final double distance;

  Distances({
    required this.pID,
    required this.distance,
  });
}

class ProductDistance {
  final ProductModel product;
  final double distance;

  ProductDistance({
    required this.product,
    required this.distance,
  });
}