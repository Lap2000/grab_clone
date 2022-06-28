import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/shipper_role_controller/order_shipped_controller.dart';
import 'package:intl/intl.dart';

import '../../../../bindings/order_detail_binding.dart';
import '../../../../database/models/order_user/order_model.dart';
import '../order/order_detail_screen.dart';

class OrderShippedScreen extends GetView<OrderShippedController> {
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
          'Đơn hàng đã giao',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(
              () => controller.isLoading1.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: controller.orderNotConfirmList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderModel currentItem =
                            controller.orderNotConfirmList.value[index];
                        return InkWell(
                          onTap: () async {
                            final result = await Get.to(
                              () => OrderDetailPage(
                                orderItem: currentItem,
                              ),
                              binding: OrderDetailBingding(),
                            );
                            if (result == 'true') {
                              Get.back();
                              Get.snackbar(
                                "",
                                "",
                                titleText: const Text(
                                  'Đơn hàng',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25),
                                ),
                                messageText: const Text(
                                  'Đã xác nhận đơn hàng '
                                  'Vào danh sách đơn hàng đã xác nhận để xem chi tiết!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
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
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
