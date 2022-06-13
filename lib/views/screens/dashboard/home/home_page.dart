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
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            //news
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            News(),
            //List suggested products
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Món ngon đề xuất cho bạn",
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
            Obx(
              () => !controller.suggestedproductDistantsList.value.isEmpty
                  ? ListViewRecommendProduct(
                      productdisList:
                          controller.suggestedproductDistantsList.value)
                  : controller.isLoading.value == false &&
                          controller.suggestedproductDistantsList.value.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Text(
                                "Chưa có sản phẩm đề xuất",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontFamily: 'Comfortaa'),
                              ),
                            ),
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child: Center(),
                        ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            //List nearly products
            const SliverToBoxAdapter(
              child: Padding(
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
            // List food
            const SliverToBoxAdapter(
              child: Padding(
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
            //List water
            const SliverToBoxAdapter(
              child: Padding(
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
