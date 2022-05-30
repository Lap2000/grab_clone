import 'cart_model.dart';

class CartList {
  List<CartModel> cartList = [];
  CartList();

  double get total {
    return cartList.fold(0.0, (double currentTotal, CartModel nextCartItem) {
      return currentTotal + nextCartItem.pTotal!;
    });
  }

  int get count {
    return cartList.fold(0, (int currentCount, CartModel nextCartItem) {
      return currentCount + nextCartItem.pAmount!;
    });
  }
}

late CartList cartListInModel = CartList();
