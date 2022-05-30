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
  const CartPage({Key? key, required this.eID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.eID.value = eID;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Giỏ hàng',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
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
                              icon: Icon(
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
                                  style: TextStyle(
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: CustomTextFormField(
                          controller: controller.userNameController,
                          text: 'Chú thích địa chỉ chính xác cho tài xế ',
                          hint:
                              'VD: 74/59 Bùi Quang Là, P12 , Q.Gò Vấp, TP.HCM',
                          onSave: (value) {
                            //controller.userName = value!;
                          },
                          validator: (value) {}),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 8,
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Text(
                            'Tổng giá giỏ hàng:  ${NumberFormat("#,##0", "en_US").format(controller.totalCart.value).toString()} VNĐ',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
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
                          var currentItem = controller.cartList.value[index];
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
                        separatorBuilder: (BuildContext context, int index) =>
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 5,
          backgroundColor: Colors.orangeAccent,
          splashColor: Colors.green,
          child: Text(
            'Đặt hàng',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
