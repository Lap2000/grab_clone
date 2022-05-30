import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/product_evalute/enterprise_controller.dart';
import 'package:grab_clone/database/models/distant_model.dart';
import 'package:grab_clone/database/models/product_model.dart';
import 'package:grab_clone/views/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../productsdetail/products_detailPage.dart';

class EnterprisePage extends GetView<EnterpriseController> {
  final double distance;
  final String image;
  final String id;
  const EnterprisePage(
      {Key? key, required this.distance, required this.image, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.idEnterprise.value = id;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height / 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width - 40,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Obx(
                          () => CustomText(
                            text: controller.enterpriseModel.value.name,
                            alignment: Alignment.center,
                            fontsize: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.black26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://assets.grab.com/wp-content/uploads/sites/11/2019/08/01200358/Mother_Bike.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${distance.toStringAsFixed(2)} km',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                CustomText(
                                  text: 'Giao ngay',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.black26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Circle-icons-phone.svg/2048px-Circle-icons-phone.svg.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                controller.enterpriseModel.value.phone,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 5 + 200 + 20,
            left: 10,
            child: CustomText(
              text: 'Danh sách sản phẩm',
              fontsize: 20,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 5 + 200 + 20 + 20 + 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 5 +
                        200 +
                        20 +
                        20 +
                        10),
                width: MediaQuery.of(context).size.width - 20,
                alignment: Alignment.center,
                child: Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: controller.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductModel item = controller.productList[index];
                            return Container(
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ProductsDetailPage(
                                        productDis: ProductDistance(
                                          distance: distance,
                                          product: item,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black87.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            item.imagesProduct[0],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 16),
                                            width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20 -
                                                        8) /
                                                    2 -
                                                16 * 2,
                                            height: 80,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: const Offset(0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${NumberFormat("#,##0", "en_US").format(item.price).toString()}  VND ',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF333333),
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFf9c920),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFF333333),
                                                            size: 14,
                                                          ),
                                                          Text(
                                                            '${item.star}',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            );
                          }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
