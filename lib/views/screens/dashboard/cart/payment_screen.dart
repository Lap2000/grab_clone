import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/cart_controller/payment_controller.dart';
import 'package:grab_clone/database/services/order_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends GetView<PaymentController> {
  final String url;

  const PaymentScreen({Key? key, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back(result: true);
          },
        ),
        title: const Text(
          'Thanh toán VnPay',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Comfortaa'),
        ),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://bill-page.vercel.app/')) {
            String ur = request.url.substring(40, 64);
            //print(ur);
            OrderServices.paymentConfirm(id: ur);
            Get.back(result: true);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
