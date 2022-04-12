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

  void onInit() {
    super.onInit();
  }

  void onReady() {
    onGetCommentList();
    super.onReady();
  }

  void Dispose() {
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
          titleText: Text(
            'Evaluate',
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          messageText: Text(
            'Sản phẩm này chưa có đánh giá !',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        );
      }
    } finally {
      isLoading(false);
    }
  }
}
