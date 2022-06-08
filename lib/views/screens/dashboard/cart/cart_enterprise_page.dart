import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/cart_controller/cart_enterprise_controller.dart';

import '../../../../bindings/cart_binding.dart';
import 'cart_page.dart';

class CartEnterprisePage extends GetView<CartEnterpriseController> {
  const CartEnterprisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Danh sách Giỏ hàng',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Obx(
              () => ListView.separated(
                //shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.cartEnterpriseList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentItem = controller.cartEnterpriseList.value[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () async {
                        final result = await Get.to(
                          () => CartPage(
                            eID: currentItem.eID,
                            eName: currentItem.eName,
                          ),
                          binding: CartBinding(),
                        );
                        if (result == 'true') {
                          Get.back();
                          Get.snackbar(
                            "",
                            "",
                            titleText: const Text(
                              'Giỏ hàng',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 25),
                            ),
                            messageText: const Text(
                              'Đặt hàng thành công! '
                              'Vào danh sách đơn hàng để xem chi tiết!',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                label: 'Delete',
                                onPressed: (BuildContext context) {
                                  Get.snackbar(
                                    "",
                                    "",
                                    titleText: const Text(
                                      'Giỏ hàng',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 25),
                                    ),
                                    messageText: Text(
                                      'Xóa ${currentItem.eName} thành công khỏi giỏ hàng!',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  );
                                  controller.deleteItemInCart(currentItem);
                                },
                              ),
                            ],
                          ),
                          child: Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          56,
                                      child: Container(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  currentItem.eName,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
