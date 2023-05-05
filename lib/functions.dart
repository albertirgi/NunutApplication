import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

openwhatsapp(BuildContext context, String number) async {
  launchUrl(Uri.parse('https://wa.me/$number?text=Halo, saya ${config.user.name} penumpang nunut ...'), mode: LaunchMode.externalApplication);
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

//from April 1, 2021 to 2021-04-01
String dateFormat(String date) {
  String day;
  String month;
  String year;
  day = date.split(" ")[1].split(",")[0];
  month = date.split(" ")[0];
  year = date.split(" ")[2];
  switch (month) {
    case "January":
      month = "01";
      break;
    case "February":
      month = "02";
      break;
    case "March":
      month = "03";
      break;
    case "April":
      month = "04";
      break;
    case "May":
      month = "05";
      break;
    case "June":
      month = "06";
      break;
    case "July":
      month = "07";
      break;
    case "August":
      month = "08";
      break;
    case "September":
      month = "09";
      break;
    case "October":
      month = "10";
      break;
    case "November":
      month = "11";
      break;
    case "December":
      month = "12";
      break;
  }
  return year + "-" + month + "-" + day;
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
