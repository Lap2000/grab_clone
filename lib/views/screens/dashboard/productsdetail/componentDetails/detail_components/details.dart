import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../database/models/distant_model.dart';

class Details extends StatelessWidget {
  final ProductDistance productDistance;

  const Details({
    Key? key,
    required this.productDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  productDistance.product.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    productDistance.product.star.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Loại sản phẩm: ' + productDistance.product.Types.join(', '),
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Giá:     ' +
                NumberFormat("#,##0", "en_US")
                    .format(productDistance.product.price)
                    .toString() +
                '   VND',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Mô tả: ' + productDistance.product.description,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Khoảng cách:  ' + productDistance.distance.toStringAsFixed(2) + ' km',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
