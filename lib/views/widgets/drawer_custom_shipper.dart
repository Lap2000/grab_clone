import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/order_shipped_binding.dart';
import 'package:grab_clone/views/screens/dashboard/shipper_role/order_shipping_screen.dart';

import '../../bindings/change_password_binding.dart';
import '../../bindings/order_shipping_binding.dart';
import '../screens/dashboard/account/security_page/change_pass_word.dart';
import '../screens/dashboard/shipper_role/order_shipped_screen.dart';

class DrawerCustomShipper extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final name;
  final email;
  final imageUR;
  DrawerCustomShipper({this.name = '', this.email = '', required this.imageUR});
  @override
  Widget build(BuildContext context) {
    // final name = 'Cửa hàng tạp hóa bán rất nhiều đồ dùng';
    return Drawer(
      child: Material(
        color: Colors.orangeAccent,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: imageUR,
              name: name,
              email: email,
              onClicked: () {},
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Thông tin tài xế',
                    icon: Icons.nature_people_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Đơn hàng đang nhận',
                    icon: Icons.library_books,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Đơn hàng đã giao',
                    icon: Icons.library_add_check,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Đổi mật khẩu',
                    icon: Icons.password,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Đăng xuất',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Comfortaa'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: 'Comfortaa'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: const TextStyle(
              color: color, fontSize: 18, fontFamily: 'Comfortaa')),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        break;
      case 1:
        Get.to(() => OrderShippingScreen(), binding: OrderShippingBinding());
        break;
      case 2:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        Get.to(() => OrderShippedScreen(), binding: OrderShippedBinding());
        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        Get.to(() => ChangePasswordPage(), binding: ChangePasswordBingding());
        break;
      case 4:
        Get.defaultDialog(
          middleTextStyle:
              const TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
          title: 'Thông báo',
          titleStyle: const TextStyle(
              color: Colors.red, fontSize: 22, fontFamily: 'Comfortaa'),
          middleText: 'Bạn có chắc chắn muốn đăng xuất không ?',
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text(
                'Hủy',
                style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
              )),
          confirm: ElevatedButton(
              onPressed: () async {
                final storage = FlutterSecureStorage();
                await storage.delete(key: 'token');
                Get.back();
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              child: const Text(
                'Xác nhận',
                style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
              )),
        );
        break;
    }
  }
}
