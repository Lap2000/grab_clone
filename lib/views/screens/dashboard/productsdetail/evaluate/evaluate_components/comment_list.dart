import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grab_clone/database/models/comment/comment_model.dart';

class CommentProduct extends StatelessWidget {
  final List<CommentModel> CommentList;

  const CommentProduct({
    Key? key,
    required this.CommentList,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CommentList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.green[100],
          shadowColor: Colors.blueGrey,
          elevation: 10,
          child: ListTile(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  content: Text(
                    '${CommentList[index].comment}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                  backgroundColor: Colors.orangeAccent,
                  actions: [
                    TextButton(
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                    ),
                  ],
                ),
              );
            },
            leading: Text(
              CommentList[index].name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.star,
                //   color: Colors.yellow[800],
                //   size: 20,
                // ),
                // const SizedBox(width: 2),
                // Text(
                //   CommentList[index].score.toString(),
                //   style: const TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(width: 5),
                Flexible(
                  child: Container(
                    child: Text(
                      '${CommentList[index].comment}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                //Text(productEvaluate[index].comment),
              ],
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[800],
                  size: 20,
                ),
                const SizedBox(width: 2),
                Text(
                  CommentList[index].score.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
