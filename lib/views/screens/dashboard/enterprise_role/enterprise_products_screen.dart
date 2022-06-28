import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/enterprise_role_controller/enterprise_products_controller.dart';
import 'package:grab_clone/views/screens/dashboard/productsdetail/product_detail_enterprise.dart';

class EnterpriseProductsPage extends GetView<EnterpriseProductsController> {
  const EnterpriseProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Danh sách sản phẩm',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0),
                      itemCount: controller.productsList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.productsList.value[index];
                        controller.pList[index] =
                            controller.productsList.value[index].isOutStock;
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ProductsDetailEnterprisePage(
                                productModel: item,
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 6,
                            shadowColor: Colors.black87.withOpacity(0.8),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 18.0 / 13.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child: Image.network(
                                          item.imagesProduct[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontFamily: 'Comfortaa-bold',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => controller.pList[index]!
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.red.withOpacity(0.6),
                                            padding:
                                                const EdgeInsets.only(top: 70),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Transform(
                                                transform:
                                                    Matrix4.rotationZ(50),
                                                child: Column(
                                                  children: const [
                                                    Text(
                                                      'Đã bán hết',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Comfortaa'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Center(),
                                ),
                                Obx(
                                  () => Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                        controller.pList[index] =
                                            !controller.pList[index]!;
                                        controller
                                            .onChangeProductStatus(item.id);
                                      },
                                      child: Icon(
                                        Icons.layers_clear_sharp,
                                        size: 25,
                                        color: controller.pList[index]!
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ),
        ),
      ),
    );
  }
}
