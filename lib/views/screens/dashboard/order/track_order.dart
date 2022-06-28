import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/models/order_user/order_model.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import '../../../../database/services/order_services.dart';

class TrackOrderScreen extends StatelessWidget {
  final OrderModel order;

  const TrackOrderScreen({Key? key, required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Theo dõi trạng thái',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              DateFormat.yMMMd().add_jm().format(order.orderDate),
              style: const TextStyle(
                  fontSize: 18, color: Colors.grey, fontFamily: 'Comfortaa'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Order ID : ${order.id}",
              style: const TextStyle(
                  fontSize: 18, color: Colors.grey, fontFamily: 'Comfortaa'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Text(
              "Đơn hàng",
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 5,
                child: StreamBuilder(
                    stream: OrderServices.getOrderByIdFlow(id: order.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      OrderModel orderGot = OrderModel(
                          orderDetail: [],
                          lat: 0,
                          lng: 0,
                          userID: '',
                          phone: '',
                          location: '',
                          name: '',
                          enterpriseID: '',
                          enterpriseName: '',
                          shipperID: '',
                          shipperName: '',
                          discount: 0,
                          totalPrice: 0,
                          shipCost: 0,
                          status: 0,
                          isOnlinePayment: false,
                          orderDate: DateTime.now(),
                          id: '');
                      if (snapshot.data == null) {
                        return IconStepper(
                          direction: Axis.vertical,
                          enableNextPreviousButtons: false,
                          enableStepTapping: false,
                          stepColor: Colors.green,
                          activeStepBorderColor: Colors.white,
                          activeStepBorderWidth: 0.0,
                          activeStepBorderPadding: 0.0,
                          lineColor: Colors.green,
                          lineLength: 70.0,
                          lineDotRadius: 2.0,
                          stepRadius: 16.0,
                          icons: const [
                            Icon(Icons.check, color: Colors.green),
                            Icon(Icons.check, color: Colors.green),
                            Icon(Icons.check, color: Colors.green),
                          ],
                        );
                      } else {
                        orderGot = OrderModel.fromMap(snapshot.data);
                      }
                      return IconStepper(
                        direction: Axis.vertical,
                        enableNextPreviousButtons: false,
                        enableStepTapping: false,
                        stepColor: Colors.green,
                        activeStepBorderColor: Colors.white,
                        activeStepBorderWidth: 0.0,
                        activeStepBorderPadding: 0.0,
                        lineColor: Colors.green,
                        lineLength: 70.0,
                        lineDotRadius: 2.0,
                        stepRadius: 16.0,
                        icons: [
                          const Icon(Icons.check, color: Colors.white),
                          Icon(Icons.check,
                              color:
                                  orderGot.status == 1 || orderGot.status == 2
                                      ? Colors.white
                                      : Colors.green),
                          Icon(Icons.check,
                              color: orderGot.status == 2
                                  ? Colors.white
                                  : Colors.green),
                        ],
                      );
                    }),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: const ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                            leading: Icon(
                              Icons.calendar_today_outlined,
                              size: 48.0,
                              color: Colors.orangeAccent,
                            ),
                            title: Text(
                              'Đang chờ xác nhận',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            subtitle: Text(
                              'Chờ cửa hàng xác nhận',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: const ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                            leading: Icon(
                              Icons.motorcycle_outlined,
                              size: 48.0,
                              color: Colors.orangeAccent,
                            ),
                            title: Text(
                              'Đang chờ giao hàng',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            subtitle: Text(
                              'Chờ tài xế giao hàng cho bạn',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: const ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                            leading: Icon(
                              Icons.timer,
                              size: 48.0,
                              color: Colors.orangeAccent,
                            ),
                            title: Text(
                              'Đã hoàn thành',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            subtitle: Text(
                              'Đơn hàng đã được giao đến nơi',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
