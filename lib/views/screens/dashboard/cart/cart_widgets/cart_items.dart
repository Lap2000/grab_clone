import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grab_clone/database/models/cart/cart_model.dart';
import 'package:intl/intl.dart';

import '../../../../../database/services/cart_services.dart';

class CartItems extends StatelessWidget {
  final CartModel cartModel;
  final Function() notifyParent;
  final Function() add;
  final Function() sub;
  CartItems(
      {required this.add,
      required this.sub,
      required this.cartModel,
      required this.notifyParent});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1 / 5,
                height: 76,
                child: Container(
                  child: Container(
                    // Add the line below
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Image.network(
                      cartModel.pImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 5,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cartModel.pName,
                            style: const TextStyle(fontSize: 18),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Đơn giá: ${NumberFormat("#,##0", "en_US").format(cartModel.pPrice).toString()} VNĐ',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tổng giá: ${NumberFormat("#,##0", "en_US").format(cartModel.pTotal).toString()} VNĐ',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        //print('tap -');
                        sub();
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'x${cartModel.pAmount}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //print('tap +');
                        add();
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -15,
                  right: -15,
                  child: IconButton(
                    onPressed: () async {
                      notifyParent();
                      await Cartservices.deleteProductFromCart(
                          pID: cartModel.pID);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
