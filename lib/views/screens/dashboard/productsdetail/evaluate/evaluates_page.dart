import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/product_evalute/product_evalute_controller.dart';
import 'package:grab_clone/database/models/product_model.dart';

import 'evaluate_components/chart_comment.dart';
import 'evaluate_components/comment_list.dart';

class EvaluatePage extends GetView<EvaluteController> {
  final ProductModel productModel;
  final bool isEvalute;
  const EvaluatePage({required this.productModel, this.isEvalute = false});
  @override
  Widget build(BuildContext context) {
    controller.idProduct.value = productModel.id;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Đánh giá sản phẩm',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: 'Comfortaa',
            ),
          ),
          actions: [
            isEvalute
                ? IconButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        transitionDuration: const Duration(milliseconds: 500),
                        barrierLabel:
                            MaterialLocalizations.of(context).dialogLabel,
                        pageBuilder: (context, _, __) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                color: Colors.white,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller:
                                                  controller.commentController,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                labelText: 'Đánh giá sản phẩm',
                                                labelStyle: const TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.white24,
                                                      width: 0.1),
                                                ),
                                                fillColor: Colors.grey[100],
                                                filled: true,
                                                prefixIcon: const Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Icon(
                                                      Icons.pending_actions),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                RatingBar.builder(
                                                  initialRating:
                                                      controller.rate.value,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.rate.value =
                                                        rating;
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  child: const Text(
                                                    'Hủy',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red,
                                                      fontFamily: 'Comfortaa',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    'Xác nhận',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontFamily: 'Comfortaa',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    controller
                                                        .onConfirmPushComment();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ).drive(Tween<Offset>(
                              begin: Offset(0, -1.0),
                              end: Offset.zero,
                            )),
                            child: child,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.comment),
                  )
                : const Center(),
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
                          pName: productModel.name,
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

  _showBottomSheet(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Column(
          children: [
            TextField(
              controller: controller.commentController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 7.0),
                prefixIcon: Icon(
                  Icons.insert_comment_outlined,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            Row(
              children: <Widget>[
                RatingBar.builder(
                  initialRating: controller.rate.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    controller.rate.value = rating;
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
          ),
          TextButton(
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            onPressed: () {
              controller.onConfirmPushComment();
            },
          ),
        ],
      ),
    );
  }
}
