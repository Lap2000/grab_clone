import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/enterprise_binding.dart';
import 'package:grab_clone/database/services/product_services.dart';
import 'package:intl/intl.dart';

import '../../../../../database/models/distant_model.dart';
import '../../enterprise/enterprise_page.dart';

class ListViewFoundProduct extends StatelessWidget {
  final List<ProductDistance> productDistantsList;

  const ListViewFoundProduct(
      {Key? key, required List<ProductDistance> productdisList})
      : productDistantsList = productdisList,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: productDistantsList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () async {
                  ProductServices.addUsersHistory(
                      pID: productDistantsList[i].product.id,
                      pName: productDistantsList[i].product.name,
                      pPrice: productDistantsList[i].product.price,
                      pImage: productDistantsList[i].product.imagesProduct[0]);
                  Get.to(
                      () => EnterprisePage(
                            distance: productDistantsList[i].distance,
                            image:
                                productDistantsList[i].product.imagesProduct[0],
                            id: productDistantsList[i].product.E_id,
                          ),
                      binding: EnterpriseBinding());
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ctx) => ProductsDetailPage(
                  //       productDis: productDistantsList[i],
                  //     ),
                  //   ),
                  // );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, top: 10, right: 15, bottom: 10),
                      height: 150,
                      //width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 25,
                      child: Container(
                        height: 120,
                        width: 140,
                        // Add the line below
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Image.network(
                          productDistantsList[i].product.imagesProduct[0],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 180,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 80,
                              child: Row(
                                children: [
                                  const SizedBox(width: 1),
                                  Text(
                                    productDistantsList[i]
                                        .product
                                        .star
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            //const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              child: Text(
                                productDistantsList[i].product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${NumberFormat("#,##0", "en_US").format(productDistantsList[i].product.price).toString()}  VND ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 170,
                              child: Text(
                                "Khoảng cách :  " +
                                    (productDistantsList[i].distance)
                                        .toStringAsFixed(2) +
                                    " km",
                                //items[i].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
