import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/shipper_role_controller/shipper_info_controller.dart';
import 'package:grab_clone/views/widgets/drawer_custom_shipper.dart';
import 'package:intl/intl.dart';

class ShipperInfoScreen extends GetView<ShipperInfoController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Obx(
        () => DrawerCustomShipper(
          name: controller.name.value,
          email: controller.email.value,
          imageUR:
              'https://jobsgo.vn/blog/wp-content/uploads/2021/07/shipper-la-gi-3.jpg',
        ),
      ),
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
            //Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://jobsgo.vn/blog/wp-content/uploads/2021/07/shipper-la-gi-3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => Text(
                  controller.name.value,
                  style: const TextStyle(
                      fontSize: 40, fontFamily: 'Comfortaa-bold'),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Username :',
                    style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(
                    () => Expanded(
                      child: Text(
                        controller.userName.value,
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Comfortaa',
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Số điện thoại :',
                    style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(
                    () => Text(
                      controller.phone.value,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Comfortaa',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Email :',
                    style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Obx(
                    () => Text(
                      controller.email.value,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Comfortaa',
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Ngày liên kết :',
                    style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        DateFormat.yMMMd()
                            .add_jm()
                            .format(controller.dateOfBirth.value),
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Comfortaa',
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     const Text(
              //       'Vị trí :',
              //       style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa'),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Expanded(
              //       child: Obx(
              //         () => Text(
              //           '${controller.lat.value.toStringAsFixed(4)}+${controller.lng.value.toStringAsFixed(4)}',
              //           style: const TextStyle(
              //             fontSize: 25,
              //             fontFamily: 'Comfortaa',
              //             color: Colors.grey,
              //           ),
              //           maxLines: 3,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
