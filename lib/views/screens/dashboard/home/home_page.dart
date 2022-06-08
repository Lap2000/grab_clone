import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/views/screens/dashboard/home/home_components/food_water_products.dart';
import 'package:grab_clone/views/screens/dashboard/home/home_components/home_news.dart';

import '../../../../controllers/user_home_controller/home_controller.dart';
import 'home_components/recommend_products.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            News(),
            const SliverToBoxAdapter(
              child: const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Món ngon gần bạn",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 22,
                      fontFamily: 'Comfortaa-bold'),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : const SliverToBoxAdapter(child: Center())),
            Obx(() => !controller.productDistantsList.value.isEmpty
                ? ListViewRecommendProduct(
                    productdisList: controller.productDistantsList.value)
                : const SliverToBoxAdapter(child: Text(''))),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            const SliverToBoxAdapter(
              child: const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Đồ ăn",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 22,
                      fontFamily: 'Comfortaa-bold'),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : const SliverToBoxAdapter(child: Center())),
            Obx(() => !controller.foodProductDistantsList.value.isEmpty
                ? FoodAndWaterProduct(
                    productdisList: controller.foodProductDistantsList.value)
                : const SliverToBoxAdapter(child: Text(''))),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            const SliverToBoxAdapter(
              child: const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Nước uống",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 22,
                      fontFamily: 'Comfortaa-bold'),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : const SliverToBoxAdapter(child: Center())),
            Obx(() => !controller.waterproductDistantsList.value.isEmpty
                ? FoodAndWaterProduct(
                    productdisList: controller.waterproductDistantsList.value)
                : const SliverToBoxAdapter(child: Text(''))),
          ],
        ),
      ),
    );
  }
}
