import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/product_evalute/product_evalute_controller.dart';
import 'package:grab_clone/database/models/product_model.dart';

import 'evaluate_components/chart_comment.dart';
import 'evaluate_components/comment_list.dart';

class EvaluatePage extends GetView<EvaluteController> {
  final ProductModel productModel;
  EvaluatePage({required this.productModel});
  @override
  Widget build(BuildContext context) {
    controller.idProduct.value = productModel.id;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Product Evaluation',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.comment),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromRGBO(10, 43, 53, 0.9),
              Color.fromRGBO(10, 43, 53, 0.6),
              Color.fromRGBO(10, 43, 53, 0.3),
            ],
          )),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : ChartComment(
                          totalComment: controller.totalComment.value,
                        ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : CommentProduct(CommentList: controller.commentList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
