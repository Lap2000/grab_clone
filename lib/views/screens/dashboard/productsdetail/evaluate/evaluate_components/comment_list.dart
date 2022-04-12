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
                  content: Text(CommentList[index].comment),
                  backgroundColor: Colors.lightGreenAccent,
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
            leading: Text(CommentList[index].name),
            title: Row(
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
                const SizedBox(width: 5),
                Flexible(
                  child: Container(
                    child: Text(
                      CommentList[index].comment,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
                //Text(productEvaluate[index].comment),
              ],
            ),
          ),
        );
      },
      //const SizedBox(height: 10),
      //ProdAvaliableColors(colors: product.avaliableColors),
      //ProdDetBottom(price: product.price,id: id,),
    );
  }
}
