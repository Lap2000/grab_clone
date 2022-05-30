import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/dashboard_controller.dart';
import 'package:grab_clone/views/screens/dashboard/account/account_page.dart';
import 'package:grab_clone/views/screens/dashboard/cart/cart_page.dart';
import 'package:grab_clone/views/screens/dashboard/search/search_page.dart';

import 'bottom_navigation.dart';
import 'home/home_page.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [HomePage(), SearchPage(), AccountPage()],
          ),
        ),
        bottomNavigationBar: CustomAnimatedBottomBar(
          containerHeight: 60,
          backgroundColor: Colors.white,
          selectedIndex: controller.tabIndex,
          onItemSelected: controller.changeTabIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text(
                  'Trang chủ',
                  style: TextStyle(fontSize: 17),
                ),
                activeColor: Colors.deepOrange),
            BottomNavyBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  'Tìm kiếm',
                  style: TextStyle(fontSize: 17),
                ),
                activeColor: Colors.deepOrange),
            BottomNavyBarItem(
              icon: Icon(Icons.account_box),
              title: Text(
                'Tài khoản',
                style: TextStyle(fontSize: 17),
              ),
              activeColor: Colors.deepOrange,
            ),
          ],
        ),
      );
    });
  }

  _bottomNavigationItems({required IconData icon, required String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
