import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/routes/route.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Grab Clone',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: (settings) {
      //   if (settings.name == AppRoutes.map) {
      //     final args = settings.arguments as MapPage;
      //     return GetPageRoute(
      //         page: () => MapPage(productDistance: args.productDistance), binding: MapBinding());
      //   }
      //   assert(false, 'Need to implement ${settings.name}');
      //   return null;
      // },
    ),
  );
}
