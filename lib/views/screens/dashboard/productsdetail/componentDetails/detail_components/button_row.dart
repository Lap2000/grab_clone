import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/evaluate_binding.dart';
import 'package:grab_clone/bindings/map_binding.dart';

import '../../../../../../database/models/distant_model.dart';
import '../../evaluate/evaluates_page.dart';
import 'map/map_page.dart';

class ButtonRow extends StatelessWidget {
  final ProductDistance productDistance;
  const ButtonRow({
    Key? key,
    required this.productDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.map_outlined),
              color: Colors.black,
              onPressed: () {
                Get.to(() => MapPage(productDistance: productDistance),
                    binding: MapBinding());
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => MapPage(productDistance: productDistance,),
                //   ),
                // );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                    () => EvaluatePage(
                          productModel: productDistance.product,
                        ),
                    binding: EvaluateBinding());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(210, 6, 156, 156),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Đánh giá sản phẩm',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: const Text('Chức năng này đang được bảo trì!'),
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
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(210, 6, 156, 156),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Thêm vào giỏ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
