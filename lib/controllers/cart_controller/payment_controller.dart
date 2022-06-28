import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  @override
  void initState() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}
