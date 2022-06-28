import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/bindings/evaluate_binding.dart';
import 'package:grab_clone/bindings/map_binding.dart';
import 'package:grab_clone/database/services/cart_services.dart';

import '../../../../../../database/models/distant_model.dart';
import '../../evaluate/evaluates_page.dart';
import 'map/map_page.dart';

class ButtonRow extends StatelessWidget {
  final ProductDistance productDistance;
  final double price;
  final bool size;
  const ButtonRow({
    Key? key,
    required this.productDistance,
    required this.price,
    required this.size,
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
              icon: const Icon(Icons.map_outlined),
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
                  color: const Color.fromARGB(210, 6, 156, 156),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Đánh giá sản phẩm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
              onTap: () async {
                Get.snackbar(
                  "",
                  "",
                  titleText: const Text(
                    'Giỏ hàng',
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                  messageText: Text(
                    'Thêm ${productDistance.product.name} thành công vào giỏ hàng!',
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                );
                await Cartservices.AddProductIntoCart(
                  pID: productDistance.product.id,
                  pName: productDistance.product.name,
                  pAmount: '1',
                  pPrice: price,
                  pImage: productDistance.product.imagesProduct[0].toString(),
                  isLarge: size,
                );
                // ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                // ScaffoldMessenger.of(context).showMaterialBanner(
                //   MaterialBanner(
                //     content: const Text('Chức năng này đang được bảo trì!'),
                //     actions: [
                //       TextButton(
                //         child: const Text(
                //           'OK',
                //           style: TextStyle(
                //             color: Colors.green,
                //           ),
                //         ),
                //         onPressed: () {
                //           ScaffoldMessenger.of(context)
                //               .hideCurrentMaterialBanner();
                //         },
                //       ),
                //     ],
                //   ),
                // );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(210, 6, 156, 156),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Thêm vào giỏ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
