import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../../../database/models/comment/comment_star_model.dart';
import '../../../../../../database/models/comment/total_comment.dart';

class ChartComment extends StatelessWidget {
  final TotalComment totalComment;
  final pName;
  const ChartComment(
      {Key? key, required this.totalComment, required this.pName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CommentStar, String>> series = [
      charts.Series(
        id: "star",
        data: totalComment.commentStarList,
        domainFn: (CommentStar series, _) => series.score.toString(),
        measureFn: (CommentStar series, _) => series.count,
        // colorFn: (StarLine series, _) => series.barColor,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Biểu đồ đánh giá sản phẩm $pName",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                ),
              ),
              Text(
                "Tổng số lượng đánh giá: ${totalComment.totalCount}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Comfortaa',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
