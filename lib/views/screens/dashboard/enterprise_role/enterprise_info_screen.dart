import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/views/widgets/drawer_custom.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/enterprise_role_controller/enterprise_info_controller.dart';

class EnterpriseInfoScreen extends GetView<EnterpriseInfoController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Obx(
        () => DrawerCustom(
          name: controller.name.value,
          email: controller.email.value,
        ),
      ),
      appBar: AppBar(
        title: const Text('Thông tin cửa hàng'),
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
                  'https://freedesignfile.com/upload/2012/07/000b_134162855718134.jpg',
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
            ],
          ),
        ),
      ),
    );
  }
}
