import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/evaluate_binding.dart';
import 'package:grab_clone/database/models/order_user/order_model.dart';
import 'package:grab_clone/database/models/product_model.dart';
import 'package:grab_clone/views/screens/dashboard/productsdetail/evaluate/evaluates_page.dart';
import 'package:intl/intl.dart';

import '../../../../database/services/order_services.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderModel orderItem;
  late bool isConfirm;
  late bool isEvaluate;
  OrderDetailPage(
      {Key? key,
      required this.orderItem,
      this.isConfirm = false,
      this.isEvaluate = false})
      : super(key: key);

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
            'Chi tiết đơn hàng',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
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
                child: SingleChildScrollView(
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
                                child: Text(
                                  orderItem.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Comfortaa',
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            orderItem.phone,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Địa chỉ giao hàng ',
                        style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(orderItem.location,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Comfortaa',
                            color: Colors.black45,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 5),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Trạng thái',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Comfortaa'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height / 5,
                            child: orderItem.isConfirm
                                ? const Text(
                                    'Đã xác nhận',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  )
                                : const Text(
                                    'Chờ xác nhận',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.orange),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Cửa hàng',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Comfortaa'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.height / 5,
                              child: Text(
                                orderItem.enterpriseName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black45),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Ngày đặt',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Comfortaa'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.height / 5,
                              child: Text(
                                DateFormat.yMMMd()
                                    .add_jm()
                                    .format(orderItem.orderDate),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black45),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              )),
                        ],
                      ),
                    ],
                  ),
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
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tổng giá giỏ hàng : ${NumberFormat("#,##0", "en_US").format(orderItem.totalPrice).toString()} VNĐ',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Giảm giá : ${NumberFormat("#,##0", "en_US").format(orderItem.discount).toString()} VNĐ',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, right: 12.0, left: 12.0, bottom: 18.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height / 5 -
                        100,
                    child: ListView.separated(
                      //shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: orderItem.orderDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentItem = orderItem.orderDetail[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width - 30,
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
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          5,
                                      height: 76,
                                      child: Container(
                                        child: Container(
                                          // Add the line below
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Image.network(
                                            currentItem.pImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          2 /
                                          5,
                                      child: Container(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  currentItem.pName,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Đơn giá : ${NumberFormat("#,##0", "en_US").format(currentItem.pPrice).toString()} VNĐ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Tổng giá : ${NumberFormat("#,##0", "en_US").format(currentItem.pTotal).toString()} VNĐ',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'x${currentItem.pAmount}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      isEvaluate
                                          ? Positioned(
                                              top: -15,
                                              right: -15,
                                              child: IconButton(
                                                onPressed: () async {
                                                  Get.to(
                                                    () => EvaluatePage(
                                                        productModel: ProductModel(
                                                            name: currentItem
                                                                .pName,
                                                            description: '',
                                                            imagesProduct: [],
                                                            Types: [],
                                                            star: 0.0,
                                                            id: currentItem.pID,
                                                            E_id: '',
                                                            price: currentItem
                                                                .pPrice),
                                                        isEvalute: true),
                                                    binding: EvaluateBinding(),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.pending_actions,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          : const Center(),
                                    ],
                                  ),
                                ],
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
            ],
          ),
        ),
        floatingActionButton: isConfirm
            ? FloatingActionButton(
                onPressed: () {
                  Get.defaultDialog(
                    middleTextStyle:
                        const TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                    title: 'Thông báo',
                    titleStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontFamily: 'Comfortaa'),
                    middleText:
                        'Bạn có chắc chắn muốn xác nhận đơn hàng này không ?',
                    cancel: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        Get.back();
                        Get.back(result: 'true');
                        OrderServices.confirmOrder(id: orderItem.id);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  'Xác nhận',
                  textAlign: TextAlign.center,
                ),
              )
            : Center(),
      ),
    );
  }
}
