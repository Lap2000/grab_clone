import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grab_clone/database/services/shipper_services.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../database/services/account_services.dart';

class ShipperInfoController extends GetxController {
  var isLoading = false.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString userName = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  //String genderString ='Male';
  Rx<DateTime> dateOfBirth = DateTime.now().obs;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 50,
  );

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  // Future<void> onGetLocation() async {
  //   print('Get location');
  //   // var geolocator = Geolocator();
  //   // var locationOptions = await Geolocator.getCurrentPosition(
  //   //     desiredAccuracy: LocationAccuracy.high);
  //   StreamSubscription<Position> positionStream =
  //       Geolocator.getPositionStream().listen((Position position) {
  //     lat.value = position.latitude;
  //     lng.value = position.longitude;
  //     print(position == null
  //         ? 'Unknown'
  //         : position.latitude.toString() +
  //             ', ' +
  //             position.longitude.toString());
  //   });
  // }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      lat.value = _locationResult.latitude!;
      lng.value = _locationResult.longitude!;
      print('${_locationResult.latitude!}+${_locationResult.longitude!}');
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _listenLocation() async {
  //   _locationSubscription.value =
  //       location.onLocationChanged.handleError((onError) {
  //     print(onError);
  //     _locationSubscription.value?.cancel();
  //     _locationSubscription.value = null;
  //   }).listen((loc.LocationData currentlocation) async {
  //     lat.value = currentlocation.latitude!;
  //     lng.value = currentlocation.longitude!;
  //   });
  // }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void onInit() {
    //doGetUserInfo();
    //onGetLocation();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    _getLocation();
    _locationSubscription = location.onLocationChanged
        .listen((loc.LocationData currentlocation) async {
      print('refresh');
      print('${currentlocation.latitude!}+${currentlocation.longitude!}');
      lat.value = currentlocation.latitude!;
      lng.value = currentlocation.longitude!;
      ShipperServices.uploadUserLocation(lat: lat.value, lng: lng.value);
    });
    print('hello');
    super.onInit();
  }

  @override
  void onReady() {
    doGetUserInfo();
    //onGetLocation();
    // _listenLocation();
    super.onReady();
    // StreamSubscription<Position> positionStream =
    //     Geolocator.getPositionStream(locationSettings: locationSettings)
    //         .listen((Position? position) {
    //   if (position != null) {
    //     lat.value = position.latitude;
    //     lng.value = position.longitude;
    //   } else
    //     print('null');
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> doGetUserInfo() async {
    isLoading.value = true;
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    //print('Đây là token : $value');
    try {
      var data = await Accountservices.getUserInfo(token: value);
      if (data != null) {
        var res = jsonDecode(data);
        //userName = res['userName'];
        name.value = res['data']['name'];
        userName.value = res['data']['userName'];
        email.value = res['data']['email'];
        phone.value = res['data']['phone'];
        dateOfBirth.value = DateTime.tryParse(res['data']['dateofBirth'])!;
      } else {
        Get.snackbar(
          "UserInfo",
          "Có lỗi xảy ra ! Hãy kiểm tra lại thông tin",
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
