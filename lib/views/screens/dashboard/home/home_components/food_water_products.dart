import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../bindings/enterprise_binding.dart';
import '../../../../../database/models/distant_model.dart';
import '../../enterprise/enterprise_page.dart';

class FoodAndWaterProduct extends StatelessWidget {
  final List<ProductDistance> productDistantsList;

  const FoodAndWaterProduct(
      {Key? key, required List<ProductDistance> productdisList})
      : productDistantsList = productdisList,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: productDistantsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                      () => EnterprisePage(
                            distance: productDistantsList[i].distance,
                            image:
                                productDistantsList[i].product.imagesProduct[0],
                            id: productDistantsList[i].product.E_id,
                          ),
                      binding: EnterpriseBinding());
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black87.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  productDistantsList[i]
                                      .product
                                      .imagesProduct[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productDistantsList[i].product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Comfortaa'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${NumberFormat("#,##0", "en_US").format(productDistantsList[i].product.price).toString()}  VND ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                (productDistantsList[i].distance)
                                        .toStringAsFixed(2) +
                                    " km",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xFF8A8989),
                                    fontSize: 14,
                                    fontFamily: 'Comfortaa-bold'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFf9c920),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xFF333333),
                                          size: 14,
                                        ),
                                        Text(
                                          productDistantsList[i]
                                              .product
                                              .star
                                              .toString(),
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  //const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
