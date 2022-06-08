import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: name(name1: 'Phạm Duy Lập', name2: '     Đinh Minh Thiện'),
          ),
          SizedBox(
            height: Get.height * 0.25,
          ),
          Center(
            child: animationContainer(),
          ),
          const SizedBox(
            height: 20,
          ),
          animationTextCustom(),
          // animationImage(),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  height: 90,
                  width: Get.width - 48,
                  child: Image.asset(
                    'assets/images/road2.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              animationImage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget name({required name1, required name2}) {
    return Transform(
      transform: Matrix4.rotationZ(50),
      child: Column(
        children: [
          Text(
            name1,
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontFamily: 'DancingScript'),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name2,
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontFamily: 'DancingScript'),
          ),
        ],
      ),
    );
  }

  Widget animationContainer() {
    return Center(
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(seconds: 1),
          width: controller.width.value,
          height: controller.height.value,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(
                //color: Colors.green.withOpacity(0.5),
                color: Color.fromRGBO(150, 155, 214, 0.9),
                spreadRadius: 3,
                blurRadius: 25,
                offset: Offset(-7, -7), // changes position of shadow
              ),
            ],
          ),
          curve: Curves.fastOutSlowIn,
          child: animationText(),
        ),
      ),
    );
  }

  Widget animationText() {
    return Center(
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(seconds: 2),
          width: controller.mWidth.value,
          curve: Curves.fastOutSlowIn,
          child: Obx(
            () => controller.mWidth > 10
                ? Image.asset(
                    'assets/images/logo3.png',
                    height: controller.mFontSize.value,
                    width: controller.mFontSize.value,
                    fit: BoxFit.fill,
                  )
                : const Text(
                    '',
                  ),
          ),
        ),
      ),
    );
  }

  Widget animationTextCustom() {
    return Center(
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(seconds: 2),
          margin: EdgeInsets.only(left: controller.textMargin.value),
          width: controller.textWidth.value,
          curve: Curves.easeInOut,
          child: Center(
            child: Obx(
              () => controller.mWidth.value == 90 && controller.textMargin < 90
                  ? Text(
                      'Food Delivery',
                      style: TextStyle(
                          fontSize: controller.textFontSize.value,
                          color: Colors.black,
                          fontFamily: 'Comfortaa'),
                    )
                  : const Text(
                      '',
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget animationImage() {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.only(left: controller.imageMargin.value),
        width: controller.imageWidth.value,
        height: 60,
        curve: Curves.easeIn,
        child: Image.asset('assets/images/grabbike.png'),
      ),
    );
  }
}
