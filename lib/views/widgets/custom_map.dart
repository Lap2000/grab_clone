import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_clone/controllers/map_controller.dart';

class CustomMap extends StatelessWidget {
  final double lat;
  final double lng;
  final String address;

  CustomMap({
    Key? key,
    required this.lat,
    required this.lng,
    required this.address,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    addMarker(
      LatLng(lat, lng),
      "origin",
      BitmapDescriptor.defaultMarker,
      'Vị trí của khách hàng',
      address,
    );
    print(lat);
    kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15.5,
    );

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
