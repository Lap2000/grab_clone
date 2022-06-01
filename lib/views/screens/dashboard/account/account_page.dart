import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/cart_enterprise_binding.dart';
import 'package:grab_clone/bindings/order_binding.dart';
import 'package:grab_clone/views/screens/dashboard/account/security_page/security_page.dart';
import 'package:grab_clone/views/screens/dashboard/cart/cart_enterprise_page.dart';

import '../../../../controllers/user_acount_controller/account_controller.dart';
import '../../../../routes/route.dart';
import '../../../widgets/gesturedetector_accoutsettings.dart';
import '../order/order_screen.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'TÀI KHOẢN',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Icon(
                        Icons.person_pin_sharp,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text("Tùy chọn",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),
                  const SizedBox(height: 10),
                  buildAccountOption(
                      context,
                      "Đổi thông tin cá nhân",
                      const Icon(
                        Icons.people_alt_rounded,
                        color: Colors.grey,
                      ), () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      Get.toNamed(AppRoutes.informationPersional);
                    });
                  }),
                  buildAccountOption(
                      context,
                      "Giỏ hàng",
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey,
                      ), () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      Get.to(() => CartEnterprisePage(),
                          binding: CartEnterpriseBinding());
                    });
                  }),
                  buildAccountOption(
                      context,
                      "Đơn hàng",
                      const Icon(
                        Icons.book_online,
                        color: Colors.grey,
                      ), () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      Get.to(() => OrderPage(), binding: OrderBinding());
                    });
                  }),
                  const SizedBox(height: 40),
                  Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text("Tài khoản & Hỗ trợ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Divider(height: 20, thickness: 2),
                  const SizedBox(height: 10),
                  buildAccountOption(
                    context,
                    "Bảo mật thông tin",
                    const Icon(
                      Icons.password_outlined,
                      color: Colors.grey,
                    ),
                    () {
                      Future.delayed(const Duration(milliseconds: 150), () {
                        Get.to(() => SecurityPage());
                      });
                    },
                  ),
                  buildAccountOption(
                      context,
                      "Trợ giúp",
                      const Icon(
                        Icons.help,
                        color: Colors.grey,
                      ), () {
                    // Future.delayed(const Duration(milliseconds: 150), () {
                    //   Get.to(() => EnterprisePage());
                    // });
                  }),
                  buildAccountOption(
                      context,
                      "Đăng xuất",
                      const Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ), () {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      //Get.toNamed(AppRoutes.informationPersional);
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
