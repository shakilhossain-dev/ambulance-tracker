import 'dart:async';

import 'package:location/location.dart' as loc;
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

late loc.LocationData _currentPosition;
late GoogleMapController mapController;
late Marker marker;
loc.Location location = loc.Location();

Future<String> getLoc() async {
  bool _serviceEnabled;
  loc.PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return "null";
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return "null";
    }
  }
  String details = "";

  _currentPosition = await location.getLocation();

  DateTime now = DateTime.now();

  details += "";
  details += DateFormat('EEE d MMM kk:mm:ss ').format(now);

  // Use geocoding package for reverse geocoding
  List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentPosition.latitude!, _currentPosition.longitude!);
  String addressLine = placemarks.isNotEmpty
      ? "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}"
      : "";

  details += "{}";
  details += _currentPosition.latitude.toString() +
      " , " +
      _currentPosition.longitude.toString();
  details += "{}";
  details += addressLine;

  return details;
}
