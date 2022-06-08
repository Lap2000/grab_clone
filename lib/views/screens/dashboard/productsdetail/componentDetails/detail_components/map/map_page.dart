import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_clone/controllers/map_controller.dart';

import '../../../../../../../database/models/distant_model.dart';

class MapPage extends GetView<MapController> {
  final ProductDistance productDistance;

  const MapPage({
    Key? key,
    required this.productDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.dis.value = productDistance.distance;
    controller.idEnterprise.value = productDistance.product.E_id;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Google Map'),
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent.withOpacity(0.6),
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Get.back();
        //       //Navigator.of(context).pop;
        //       //controller.onBack();
        //     },
        //   ),
        // ),
        body: Center(
          child: Stack(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: controller.kGooglePlex,
                        myLocationEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: Set<Marker>.of(controller.markers.value),
                        polylines: Set<Polyline>.of(controller.polylines.value),
                        // onMapCreated: (GoogleMapController xcontroller) {
                        //   controller.mapController.complete(xcontroller);
                        // }
                      ),
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
                    Expanded(
                      child: Text(
                        productDistance.distance.toStringAsFixed(2) + ' Km',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
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
