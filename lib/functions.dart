import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

openwhatsapp(BuildContext context, String number) async {
  var whatsappURl_android = "https://wa.me/" + number;
  var whatappURL_ios = "https://api.whatsapp.com/send?phone=$number";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
      await launchUrl(Uri.parse(whatappURL_ios));
    } else {
      Fluttertoast.showToast(
          msg: "whatsapp no installed", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
      await launchUrl(Uri.parse(whatsappURl_android));
    } else {
      Fluttertoast.showToast(
          msg: "whatsapp no installed", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    }
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

startCalculate(double startLat, double startLong, double endLat, double endLong) async {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(startLat, startLong);
  LatLng endLocation = LatLng(endLat, endLong);

  double distance = 0.0;

  bool mapLocationListLoading = true;
  List<MapLocation> mapLocationList = [];
  String chosenMapLocation = '';

  markers.add(
    Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ),
  );

  markers.add(
    Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ),
  );

  List<LatLng> polylineCoordinates = [];

  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    config.googleAPiKey,
    PointLatLng(startLocation.latitude, startLocation.longitude),
    PointLatLng(endLocation.latitude, endLocation.longitude),
    travelMode: TravelMode.driving,
  );

  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  } else {
    print(result.errorMessage);
  }

  //polulineCoordinates is the List of longitute and latidtude.
  double totalDistance = 0;
  for (var i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += calculateDistance(polylineCoordinates[i].latitude, polylineCoordinates[i].longitude, polylineCoordinates[i + 1].latitude, polylineCoordinates[i + 1].longitude);
  }

  distance = totalDistance;

  return distance;
}

String priceFormat(String price) {
  double numValue = double.parse(price);
  NumberFormat currencyFormatter = NumberFormat.simpleCurrency(locale: "id", decimalDigits: 0, name: "");
  return currencyFormatter.format(numValue);
}

class PopWithResults<T> {
  /// poped from this page
  final String fromPage;

  /// pop until this page
  final String toPage;

  /// results
  final dynamic results;

  /// constructor
  PopWithResults({@required required this.fromPage, @required required this.toPage, required this.results});
}
