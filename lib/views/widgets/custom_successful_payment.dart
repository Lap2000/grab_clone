import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSuccessfulPayment extends StatelessWidget {
  const CustomSuccessfulPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                "https://raw.githubusercontent.com/Dr-Usman/thankupage/master/assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text(
              "Cảm ơn quý khách !",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w600,
                fontSize: 36,
                fontFamily: 'Comfortaa',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Text(
              "Thanh toán đơn hàng \n thành công ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'Comfortaa',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const Text(
              "Quý khách sẽ được chuyển về trang chủ ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: 'Comfortaa',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Get.back(result: true);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Center(
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
