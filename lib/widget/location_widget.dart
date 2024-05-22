import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helper/location_helper.dart';
import '../services/notification_services.dart';
import '../utils/common_widgets.dart';
import 'app_textfield.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController? mapController;

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.9778, 72.4979),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  ValueNotifier<List<Marker>> markerAddNotifier = ValueNotifier([]);

  @override
  void initState() {
    LocationHelper().startLocationServices();
    listenToLocationUpdate();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LocationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<LocationData>(
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Getting your location Please wait!'),
                ],
              ),
            );
          }

          return ValueListenableBuilder<List<Marker>>(
            builder: (BuildContext context, List<Marker> value, Widget? child) {
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(_markers),
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onTap: (LatLng argument) {
                  addMarkerDialog(argument);
                },
              );
            },
            valueListenable: markerAddNotifier,
          );
        },
        stream: LocationHelper().getLocationUpdateStream(),
      ),
    );
  }

  void addMarkerDialog(LatLng argument) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Add Location Details"),
                const SizedBox(height: 10),
                AppTextField(
                  controller: nameController,
                  labelText: 'Name',
                  containerPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  maxLength: 20,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: addressController,
                  labelText: 'Address',
                  containerPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  maxLength: 100,
                  maxLines: 3,
                )
              ],
            ),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  checkValidationAndAddMarker(argument);
                },
                child: const Text('Add'),
              ),
              OutlinedButton(
                onPressed: () {
                  clearDialog();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  void checkValidationAndAddMarker(LatLng locationOfMarker) {
    if (nameController.text.trim().isEmpty) {
      commonToast(message: "Please enter name.");
    } else if (addressController.text.trim().isEmpty) {
      commonToast(message: "Please enter Address.");
    } else {
      addMarker(locationOfMarker);
    }
  }

  addMarker(LatLng locationOfMarker) {
    _markers.add(Marker(
        markerId: MarkerId(nameController.text),
        position: locationOfMarker,
        infoWindow: InfoWindow(title: nameController.text, snippet: addressController.text)));
    // added marker in a stream ...
    markerAddNotifier.value = _markers;
    clearDialog();
  }

  clearDialog() {
    nameController.clear();
    addressController.clear();
    Navigator.pop(context);
  }

  void listenToLocationUpdate() {
    LocationHelper().getLocationUpdateStream().listen((event) {
      if (_controller.isCompleted && event.latitude != null && event.longitude != null) {
        final p = CameraPosition(target: LatLng(event.latitude!, event.longitude!), zoom: 14.4746);

        mapController!.animateCamera(CameraUpdate.newCameraPosition(p));

        calculateDistanceAndShowNotification(LatLng(event.latitude!, event.longitude!));
      }
    });
  }

  calculateDistanceAndShowNotification(LatLng myLatLng) {
    _markers.forEach((element) {
      double distance = LocationHelper().calculateDistanceInKm(
          element.position.latitude, element.position.longitude, myLatLng.latitude, myLatLng.longitude);

      if (distance < 10) {
        print("show notification here");
        NotificationService().showNotification(
          0,
          'Test Notification',
          'This is the body of the test notification.',
        );
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
