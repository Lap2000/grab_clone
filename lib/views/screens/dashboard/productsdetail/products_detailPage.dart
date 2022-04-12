import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grab_clone/database/models/distant_model.dart';

import 'componentDetails/detail_container.dart';

class ProductsDetailPage extends StatelessWidget {
  final ProductDistance productDistance;

  ProductsDetailPage({Key? key, required ProductDistance productDis})
      : productDistance = productDis,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
            Navigator.of(context).pop(true);
          },
        ),
        title: Text(
          productDistance.product.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(10, 43, 53, 0.9),
            Color.fromRGBO(10, 43, 53, 0.6),
            Color.fromRGBO(10, 43, 53, 0.3),
          ],
        )),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    productDistance.product.imagesProduct[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: DetailContainer(
                productDistance: productDistance,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
