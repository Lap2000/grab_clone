import 'package:flutter/material.dart';

import '../../../../../database/models/distant_model.dart';
import 'detail_components/button_row.dart';
import 'detail_components/details.dart';

class DetailContainer extends StatelessWidget {
  final ProductDistance productDistance;

  const DetailContainer({
    Key? key,
    required this.productDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Details(
              productDistance: productDistance,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //ProdDetBottom(price: product.price!,id: id, Product: product,),
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ButtonRow(
                productDistance: productDistance,
              )),
        ],
      ),
    );
  }
}
