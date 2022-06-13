import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/cart_controller/cart_screen_controller.dart';
import 'package:grab_clone/views/screens/dashboard/cart/cart_widgets/cart_items.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_textformfield.dart';

class CartPage extends GetView<CartController> {
  final String eID;
  final String eName;
  const CartPage({Key? key, required this.eID, required this.eName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.eID.value = eID;
    controller.eName.value = eName;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.back(result: true);
            },
          ),
          title: const Text(
            'Giỏ hàng',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {},
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height / 5,
                                  child: Obx(
                                    () => Text(
                                      controller.name.value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Text(
                                controller.phoneNumber.value,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: controller.locationFormKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: CustomTextFormField(
                                controller: controller.locationController,
                                text: 'Chú thích địa chỉ chính xác cho tài xế ',
                                hint:
                                    'VD: 74/59 Bùi Quang Là, P12 , Q.Gò Vấp, TP.HCM',
                                onSave: (value) {
                                  //controller.userName = value!;
                                },
                                validator: (value) {
                                  return controller.validateNull(value!);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 8,
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
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
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Text(
                                'Tổng giá giỏ hàng:  ${NumberFormat("#,##0", "en_US").format(controller.totalCart.value).toString()} VNĐ',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              ),
                            ),
                          ),
                          // Text(
                          //   'Số lượng: \$' + '${controller.totalCart.value}',
                          //   style: TextStyle(fontSize: 18, color: Colors.grey),
                          // ),
                        ],
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 12.0, left: 12.0, bottom: 18.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height / 5 -
                            100,
                        child: Obx(
                          () => ListView.separated(
                            //shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.cartList.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              var currentItem =
                                  controller.cartList.value[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CartItems(
                                  cartModel: currentItem,
                                  notifyParent: () {
                                    controller.deleteIteminCart(currentItem);
                                  },
                                  add: () {
                                    controller.addCountIteminCart(currentItem);
                                  },
                                  sub: () {
                                    controller.subCountIteminCart(currentItem);
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.isOrder.value
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white70,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const Center(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              middleTextStyle:
                  const TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
              title: 'Thông báo',
              titleStyle: const TextStyle(
                  color: Colors.red, fontSize: 22, fontFamily: 'Comfortaa'),
              middleText: 'Bạn có chắc chắn muốn đặt đơn hàng này không ?',
              cancel: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                child: const Text(
                  'Hủy',
                  style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                ),
              ),
              confirm: ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.value == false) {
                    if (controller.phoneNumber == '') {
                      Get.back();
                      Get.snackbar(
                        "",
                        "",
                        titleText: const Text(
                          'Giỏ hàng',
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                        messageText: const Text(
                          'Cập nhật số điện thoại trong thông tin cá nhân để tiếp tục!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      );
                    } else {
                      Get.back(result: 'true');
                      controller.placeOrder(context: context);
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                ),
              ),
            );
          },
          elevation: 5,
          backgroundColor: Colors.orangeAccent,
          splashColor: Colors.green,
          child: const Text(
            'Đặt hàng',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
