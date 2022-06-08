import 'package:grab_clone/database/models/comment/comment_model.dart';

import 'comment_star_model.dart';

class TotalComment {
  late List<CommentStar> commentStarList = [
    CommentStar(score: 1.0),
    CommentStar(score: 1.5),
    CommentStar(score: 2.0),
    CommentStar(score: 2.5),
    CommentStar(score: 3.0),
    CommentStar(score: 3.5),
    CommentStar(score: 4.0),
    CommentStar(score: 4.5),
    CommentStar(score: 5.0),
  ];

  //TotalComment(this.commentStarList);

  int get totalCount {
    return commentStarList.fold(0,
        (int currentTotal, CommentStar nextCommentStar) {
      return currentTotal + nextCommentStar.count;
    });
  }

  void addToTotalComent(List<CommentModel> commentList) {
    for (int i = 0; i < commentList.length; i++) {
      for (int j = 0; j < commentStarList.length; j++) {
        if (commentList[i].score == commentStarList[j].score) {
          commentStarList[j].addcount();
          break;
        }
      }
    }
  }
}
