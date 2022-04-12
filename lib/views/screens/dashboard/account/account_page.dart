

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/acountController/account_controller.dart';
import 'package:grab_clone/views/screens/auth/register.dart';

import '../../../../routes/route.dart';
import '../../../widgets/gesturedetector_accoutsettings.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text('TÀI KHOẢN', style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.person_pin_sharp,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text("Tùy chọn", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(height: 20, thickness: 1),
                    SizedBox(height: 10),
                    buildAccountOption(
                        context,
                        "Đổi thông tin cá nhân",
                        Icon(Icons.people_alt_rounded, color: Colors.grey,),
                    ),
                    buildAccountOption(context, "Lịch sử tìm kiếm", Icon(Icons.history, color: Colors.grey,)),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text("Tài khoản & Hỗ trợ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(height: 20, thickness: 2),
                    SizedBox(height: 10),
                    buildAccountOption(context, "Đổi mật khẩu", Icon(Icons.password_outlined, color: Colors.grey,)),
                    buildAccountOption(context, "Trợ giúp", Icon(Icons.help, color: Colors.grey,)),
                    buildAccountOption(context, "Đăng xuất", Icon(Icons.logout, color: Colors.grey,)),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}