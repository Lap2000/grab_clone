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
        body: Column(
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomSearchBar(
                controller: controller.findtextController,
                onClick: controller.onFind,
              ),
            ),
            // const SliverToBoxAdapter(child: SizedBox(height: 5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const Text(
                    'Bán kính tìm kiếm :',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Comfortaa'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => DropdownButton(
                      onChanged: (newValue) {
                        controller.setSelected(newValue);
                      },
                      value: controller.findRSelected.value,
                      items: <int>[1, 2, 3, 4, 5, 10, 15, 20, 30]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Km',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? Center(child: CircularProgressIndicator())
                : Center()),
            Obx(() => !controller.productDistantsList.value.isEmpty
                ? Expanded(
                    child: ListViewFoundProduct(
                        productdisList: controller.productDistantsList.value),
                  )
                : Text('')),
          ],
        ),
      ),
    );
  }
}
