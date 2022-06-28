import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/models/comment/comment_model.dart';
import 'package:grab_clone/database/services/product_services.dart';

import '../../database/models/comment/total_comment.dart';

class EvaluteController extends GetxController {
  late TotalComment tTC = TotalComment();
  late Rx<TotalComment> totalComment = Rx(tTC);
  late RxList<CommentModel> commentList = RxList<CommentModel>();
  final isLoading = false.obs;
  final RxString idProduct = ''.obs;
  final evaluateFormKey = GlobalKey<FormState>();
  late TextEditingController commentController;
  late RxDouble rate = 0.0.obs;
  late RxBool isValuated = false.obs;
  late RxBool enterprise = false.obs;

  void onInit() {
    commentController = TextEditingController();
    super.onInit();
  }

  void onReady() {
    onGetCommentList();
    if (enterprise.value == true) {
      getUserEvaluate();
    }
    super.onReady();
  }

  void Dispose() {
    commentController.dispose();
    super.dispose();
  }

  onGetCommentList() async {
    isLoading(true);
    try {
      List<CommentModel> _futureOfList =
          await ProductServices.getCommentList(idProduct: idProduct.value);
      commentList.value = _futureOfList;
      if (!_futureOfList.isEmpty) {
        totalComment.value.addToTotalComent(_futureOfList);
        print(totalComment.value.commentStarList.length);
      } else {
        print('Lap - ' + _futureOfList.toString());
        Get.snackbar(
          "Evaluate",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
          titleText: const Text(
            'Evaluate',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Sản phẩm này chưa có đánh giá !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  getUserEvaluate() async {
    try {
      var data = await ProductServices.getUserEvaluate(pID: idProduct.value);
      if (jsonDecode(data)['data']['score'] != null) {
        print(jsonDecode(data));
        isValuated.value = true;
        commentController.text = '${jsonDecode(data)['data']['comment']}';
        rate.value = jsonDecode(data)['data']['score'].toDouble();
      } else {
        commentController.text = 'Bạn chưa đánh giá sản phẩm này';
        print('Lap -  ${commentController.text}');
      }
    } finally {}
  }

  onConfirmPushComment() async {
    if (isValuated.value) {
      print('if');
      if (commentController.text == '') {
        Get.snackbar(
          "Evaluate",
          "Bạn chưa điền đánh giá !",
          titleText: const Text(
            'Evaluate',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Bạn chưa điền đánh giá !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      } else {
        Get.back();
        isLoading(true);
        var data = await ProductServices.editEvaluate(
          pID: idProduct.value,
          score: rate.value,
          comment: commentController.text,
        );
        String mess = '';
        bool warning = false;
        if (data != null) {
          var res = jsonDecode(data);
          print(res);
          mess = res['message'];
          print('Lap - $mess');
        }
        if (mess ==
                'Bạn đã vi phạm nguyên tắc đánh giá của FindWhere! Nếu còn cố tình tái phạm bạn sẽ bị khóa tài khoản!' ||
            mess ==
                'Bạn đã bị khóa tài khoản do liên tục vi phạm nguyên tắc đánh giá của FindWhere! Nếu có bất cứ thắc mắc nào xin liên hệ email: phamduylap123456@gmail.com') {
          warning = true;
        }
        commentList.value.clear();
        totalComment.value = TotalComment();
        Get.snackbar(
          "Evaluate",
          "Đánh giá sản phẩm thành công !",
          titleText: Text(
            'Evaluate',
            style: TextStyle(
                color: warning == true ? Colors.red : Colors.green,
                fontSize: 25),
          ),
          messageText: Text(
            mess,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
        onGetCommentList();
      }
    } else {
      print('else');
      if (commentController.text == '' || rate.value == 0) {
        Get.snackbar(
          "Evaluate",
          "Bạn chưa điền đánh giá !",
          titleText: const Text(
            'Evaluate',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: const Text(
            'Bạn chưa điền đánh giá !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      } else {
        Get.back();
        isLoading(true);
        var data = await ProductServices.addEvaluate(
          pID: idProduct.value,
          score: rate.value,
          comment: commentController.text,
        );
        String mess = '';
        bool warning = false;
        if (data != null) {
          var res = jsonDecode(data);
          print(res);
          mess = res['message'];
          print('Lap - $mess');
        }
        if (mess ==
                'Bạn đã vi phạm nguyên tắc đánh giá của FindWhere! Nếu còn cố tình tái phạm bạn sẽ bị khóa tài khoản!' ||
            mess ==
                'Bạn đã bị khóa tài khoản do liên tục vi phạm nguyên tắc đánh giá của FindWhere! Nếu có bất cứ thắc mắc nào xin liên hệ email: phamduylap123456@gmail.com') {
          warning = true;
        }
        commentList.value.clear();
        totalComment.value = TotalComment();
        Get.snackbar(
          "Evaluate",
          "Đánh giá sản phẩm thành công !",
          titleText: Text(
            'Evaluate',
            style: TextStyle(
                color: warning == true ? Colors.red : Colors.green,
                fontSize: 25),
          ),
          messageText: Text(
            mess,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
        onGetCommentList();
      }
    }
  }
}
