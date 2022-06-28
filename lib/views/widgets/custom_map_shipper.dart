import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_clone/controllers/map_controller.dart';

class CustomMapShipper extends StatelessWidget {
  final double latU;
  final double lngU;
  final String addressU;
  final double latE;
  final double lngE;
  final String addressE;
  final List<Polyline> polylines;
  CustomMapShipper(
      {Key? key,
      required this.latU,
      required this.lngU,
      required this.addressU,
      required this.latE,
      required this.lngE,
      required this.addressE,
      required this.polylines})
      : super(key: key);

  List<Marker> markers = <Marker>[];
  late final MapController mapController;
  //Map<PolylineId, Polyline> polylines = {};
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(10.835539944308536, 106.63938148207266),
    zoom: 15.5,
  );

  late String addressUser = '';

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

  onCreate() {
    print(polylines);
    addMarker(
      LatLng(latU, lngU),
      "Khách hàng",
      BitmapDescriptor.defaultMarker,
      'Vị trí của khách hàng',
      addressU,
    );
    addMarker(
      LatLng(latE, lngE),
      "Cửa hàng",
      BitmapDescriptor.defaultMarkerWithHue(90),
      'Vị trí của cửa hàng',
      addressE,
    );
    kGooglePlex = CameraPosition(
      target: LatLng(latU, lngU),
      zoom: 15.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    onCreate();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                markers: Set<Marker>.of(markers),
                polylines: Set<Polyline>.of(polylines),
                // onMapCreated: (GoogleMapController xcontroller) {
                //   controller.mapController.complete(xcontroller);
                // }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
