import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/search_controller.dart';
import 'package:grab_clone/views/screens/dashboard/search/search_widget/custom_search.dart';
import 'package:grab_clone/views/screens/dashboard/search/search_widget/listview_foundProducts.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 5)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomSearchBar(
                  controller: controller.findtextController,
                  onClick: controller.onFind,
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : const SliverToBoxAdapter(child: Center())),
            Obx(() => !controller.productDistantsList.value.isEmpty
                ? ListViewFoundProduct(
                    productdisList: controller.productDistantsList.value)
                : const SliverToBoxAdapter(child: Text(''))),
          ],
        ),
      ),
    );
  }
}
