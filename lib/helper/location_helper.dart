import 'dart:async';
import 'dart:math';

import 'package:location/location.dart';

import '../utils/common_widgets.dart';

class LocationHelper {
  static final LocationHelper _singleton = LocationHelper._internal();

  factory LocationHelper() {
    return _singleton;
  }

  LocationHelper._internal();

  Location location = Location();

  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;

  StreamController<LocationData> locationChangeStream = StreamController.broadcast();

  startLocationServices() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Please enable location service.');
        commonToast(message: "Please enable location service.");
        return;
      } else {
        checkPermissionGranted();
      }
    } else {
      checkPermissionGranted();
    }
  }

  checkPermissionGranted() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Please allow location permission');
        commonToast(message: "Please allow location permission.");
        return;
      } else {
        getLocation();
        startLocationStream();
      }
    } else {
      getLocation();
      startLocationStream();
    }
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }

  startLocationStream() {
    location.changeSettings(interval: 3000, distanceFilter: 100);
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      locationChangeStream.add(currentLocation);
    }).onError((handleError) {
      print(" handleError     Erorr      here");
      commonToast(message: "Location Error!.");
    });
  }

  Stream<LocationData> getLocationUpdateStream() {
    return locationChangeStream.stream;
  }

  getLocationObj() {
    return location;
  }

  enableBackgroundMode() {
    location.enableBackgroundMode(enable: true);
  }

  double calculateDistanceInKm(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295; //conversion factor from radians to decimal degrees, exactly math.pi/180
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var radiusOfEarth = 6371;
    return radiusOfEarth * 2 * asin(sqrt(a));
  }
}
