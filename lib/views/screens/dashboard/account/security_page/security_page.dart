import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/change_password_binding.dart';
import 'package:grab_clone/views/screens/dashboard/account/security_page/change_pass_word.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Bảo mật thông tin',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                child: const SingleChildScrollView(
                  child: Text(
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.'
                      'Hãy giữ mật khẩu của bạn đủ độ khó để bảo vệ tài khoản của mình.',
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa')),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => ChangePasswordPage(),
                        binding: ChangePasswordBingding());
                  },
                  child: const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontFamily: 'Comfortaa'),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                child: const SingleChildScrollView(
                  child: Text(
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.'
                      'Liên kết số điện thoại giúp bạn dễ dàng lấy lại mật khẩu.',
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa')),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Đổi số điện thoại',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontFamily: 'Comfortaa'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
