import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/shipper_role_controller/order_shipping_controller.dart';
import 'package:grab_clone/database/models/order_user/order_model.dart';
import 'package:intl/intl.dart';

import '../../../../bindings/order_detail_binding.dart';
import '../../../../database/services/shipper_services.dart';
import '../order/order_detail_screen.dart';

class OrderShippingScreen extends GetView<OrderShippingController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          'Đơn hàng đang giao',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: ShipperServices.getShipperOrderFlow(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<OrderModel> orderConfirmList = [];
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    orderConfirmList = snapshot.data;
                  }
                  return ListView.builder(
                    itemCount: orderConfirmList.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderModel currentItem = orderConfirmList[index];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => OrderDetailPage(
                              orderItem: currentItem,
                              isShipper: true,
                            ),
                            binding: OrderDetailBingding(),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://nhathauxaydung24h.com/wp-content/uploads/2021/12/avatar-an-uong.jpg',
                              ),
                            ),
                          ),
                          title: Text(
                            currentItem.name,
                            style: const TextStyle(
                                fontSize: 20, fontFamily: 'Comfortaa'),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd()
                                .add_jm()
                                .format(currentItem.orderDate),
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Comfortaa'),
                          ),
                          trailing: Text(
                            '${currentItem.totalPrice}đ',
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
