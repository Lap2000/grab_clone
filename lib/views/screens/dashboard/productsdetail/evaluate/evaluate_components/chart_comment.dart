import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../../../database/models/comment/comment_star_model.dart';
import '../../../../../../database/models/comment/total_comment.dart';

class ChartComment extends StatelessWidget {
  final TotalComment totalComment;
  const ChartComment({Key? key, required this.totalComment}) : super(key: key);

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
                "Biểu đồ đánh giá sản phẩm ",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                  child: charts.BarChart(
                series,
                animate: true,
              )),
              Text(
                "Tổng số lượng đánh giá: ",
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
