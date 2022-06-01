import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/order_controller/order_screen_controller.dart';
import 'package:grab_clone/database/models/order_user/order_model.dart';
import 'package:grab_clone/views/screens/dashboard/order/order_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Đơn hàng',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Đơn hàng của tôi',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa-Bold'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: TabBar(
                controller: controller.tabController,
                // indicatorColor: Colors.green,
                // labelColor: Colors.red,
                // indicator: MaterialIndicator(
                //   height: 3,
                //   topLeftRadius: 0,
                //   topRightRadius: 0,
                //   bottomLeftRadius: 5,
                //   bottomRightRadius: 5,
                //   horizontalPadding: 16,
                //   tabPosition: TabPosition.bottom,
                // ),
                indicator: RectangularIndicator(
                  bottomLeftRadius: 100,
                  bottomRightRadius: 100,
                  topLeftRadius: 100,
                  topRightRadius: 100,
                  color: Colors.black12,
                ),
                tabs: const <Widget>[
                  Tab(
                    child: Text(
                      'Đơn hàng đang chờ',
                      style: TextStyle(color: Colors.orange, fontSize: 18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Đơn hàng đã xác nhận',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height - 206,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: controller.tabController,
                children: <Widget>[
                  Obx(
                    () => controller.isLoading1.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount:
                                controller.orderNotConfirmList.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              OrderModel currentItem =
                                  controller.orderNotConfirmList.value[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () =>
                                        OrderDetailPage(orderItem: currentItem),
                                  );
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    alignment: Alignment.center,
                                    child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'https://nhathauxaydung24h.com/wp-content/uploads/2021/12/avatar-an-uong.jpg',
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    currentItem.enterpriseName,
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
                  Obx(
                    () => controller.isLoading2.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: controller.orderConfirmList.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              OrderModel currentItem =
                                  controller.orderConfirmList.value[index];
                              return ListTile(
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
                                  currentItem.enterpriseName,
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
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
