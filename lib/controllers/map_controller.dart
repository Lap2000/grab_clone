import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../database/services/product_services.dart';

class MapController extends GetxController {
  //final Rxn<ProductDistance> productDistance = Rxn<ProductDistance>();
  final RxDouble dis = RxDouble(20.0);
  final RxBool isLoading = true.obs;
  final RxString idEnterprise = ''.obs;

  final RxDouble userLat = RxDouble(0.0);
  final RxDouble userLng = RxDouble(0.0);

  final RxDouble enterpriseLat = RxDouble(0.0);
  final RxDouble enterpriseLng = RxDouble(0.0);

  RxList<Marker> markers = <Marker>[].obs;
  RxList<Polyline> polylines = <Polyline>[].obs;
  late final MapController mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  //Map<PolylineId, Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(10.835539944308536, 106.63938148207266),
    zoom: 15.5,
  );

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    //print('hế lô' +idEnterprise.value);
    //getUsersLocation();
    //getEnterprisesLocation();
    onGetMap();
    super.onReady();
  }

  void Dispose() {
    markers.clear();
    polylines.clear();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onGetMap() {
    isLoading(true);
    try {
      getUsersLocation();
      getEnterprisesLocation();
    } finally {
      isLoading(false);
    }
  }

  Future<void> getUsersLocation() async {
    final storage = new FlutterSecureStorage();
    String lat = (await storage.read(key: 'User_lat'))!;
    String lng = (await storage.read(key: 'User_lng'))!;
    userLat.value = double.tryParse(lat)!;
    userLng.value = double.tryParse(lng)!;
    addMarker(
      LatLng(userLat.value, userLng.value),
      "origin",
      BitmapDescriptor.defaultMarker,
      'Vị trí của bạn',
      'Đây là vị trí bạn đứng trên bản đồ',
    );
  }

  Future<void> getEnterprisesLocation() async {
    dynamic enterprise =
        await ProductServices.getEnterpriseOfProduct(Eid: idEnterprise.value);
    //double distance = _coordinateDistance(double.parse(userLat.value),double.parse(userLng.value),enterprise['lat'],enterprise['lng']);
    enterpriseLat.value = enterprise['lat'];
    enterpriseLng.value = enterprise['lng'];
    addMarker(
      LatLng(enterpriseLat.value, enterpriseLng.value),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
      enterprise['name'],
      'Đây là vị trí cửa hàng bán sản phẩm',
    );
    print(markers.value);
    getPolyline(
        userLat.value, userLng.value, enterpriseLat.value, enterpriseLng.value);
  }

  void completeController(GoogleMapController controller) {
    _controller.complete(controller);
  }

  addMarker(
      LatLng position, String id, BitmapDescriptor descriptor, title, snippet) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      draggable: true,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
    );
    markers.add(marker);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: Colors.redAccent,
      width: 3,
    );
    polylines.add(polyline);
  }

  void getPolyline(double originLatitude, double originLongitude,
      double destLatitude, double destLongitude) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      //"AIzaSyAlYsTlqJPvWDN7Q3Qx5h-evCjB15clESw", // My google API key
      //"AIzaSyBAzCAAy1W9UlnVaW8qABvEepsNlFS7rMc", // Huy's API key
      "AIzaSyC6KJqaBbVuV_v6RblhP-kNwajh2AqpJKw", // My new google API key
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
  }
}
