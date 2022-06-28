import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_clone/database/services/product_services.dart';

import '../../database/models/shipper_model.dart';

class OrderDetailController extends GetxController {
  RxString shipperID = ''.obs;
  RxString shipperName = ''.obs;
  Rx<ShipperModel> shipperCurrent =
      ShipperModel(name: '', phone: '', lat: 0, lng: 0, id: '').obs;
  Rx<List<ShipperModel>> items = Rx<List<ShipperModel>>([]);
  RxList<Polyline> polylines = <Polyline>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxString eID = ''.obs;
  RxDouble eLat = 0.0.obs;
  RxDouble eLng = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onInit
    onGetLocaitonEnterprise();
    super.onReady();
  }

  getPolyline(double originLatitude, double originLongitude,
      double destLatitude, double destLongitude) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      //"AIzaSyAlYsTlqJPvWDN7Q3Qx5h-evCjB15clESw", // My google API key
      //"AIzaSyBAzCAAy1W9UlnVaW8qABvEepsNlFS7rMc", // Huy's API key
      //"AIzaSyC6KJqaBbVuV_v6RblhP-kNwajh2AqpJKw", // My new google API key
      "AIzaSyBPEMzSICVD2j9cS9bskOHGT46lAIDUy14", //
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
    return polylines.value;
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: Colors.redAccent,
      width: 3,
    );
    polylines.value.add(polyline);
  }

  onGetLocaitonEnterprise() async {
    var data = await ProductServices.getEnterPrise2(id: eID.value);
    eLat.value = data['lat'];
    eLng.value = data['lng'];
  }
}
