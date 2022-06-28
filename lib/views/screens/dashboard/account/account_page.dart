import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Icon(
                        Icons.person_pin_sharp,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Tùy chọn",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa'),
                      ),
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
                      Text(
                        "Tài khoản & Hỗ trợ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa'),
                      ),
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
                    //   Get.to(() => ShipperInfoScreen(),
                    //       binding: ShipperInfoBinding());
                    // });
                    // Future.delayed(const Duration(milliseconds: 150), () {
                    //   Get.to(() => const CustomSuccessfulPayment());
                    // });

                    // Future.delayed(const Duration(milliseconds: 150), () {
                    //   Get.to(() => TrackOrderScreen());
                    // });
                  }),
                  buildAccountOption(
                      context,
                      "Đăng xuất",
                      const Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ), () {
                    Future.delayed(const Duration(milliseconds: 150), () async {
                      Get.defaultDialog(
                        middleTextStyle: const TextStyle(
                            fontSize: 18, fontFamily: 'Comfortaa'),
                        title: 'Thông báo',
                        titleStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontFamily: 'Comfortaa'),
                        middleText: 'Bạn có chắc chắn muốn đăng xuất không ?',
                        cancel: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Comfortaa'),
                            )),
                        confirm: ElevatedButton(
                            onPressed: () async {
                              final storage = FlutterSecureStorage();
                              await storage.delete(key: 'token');
                              Get.back();
                              Get.back();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Comfortaa'),
                            )),
                      );
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
