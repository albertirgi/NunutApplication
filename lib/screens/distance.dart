import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/resources/mapLocationApi.dart';
import 'package:nunut_application/theme.dart';

import '../configuration.dart';

class Distance extends StatefulWidget {
  const Distance({super.key});

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(-7.3393869398079845, 112.73756389693006);
  LatLng endLocation = LatLng(-7.286820985264024, 112.67580414728886);

  double distance = 0.0;

  bool mapLocationListLoading = true;
  List<MapLocation> mapLocationList = [];
  String chosenMapLocation = '';

  @override
  void initState() {
    initMapLocationList();
    startCalculate();
    super.initState();
  }

  startCalculate() {
    markers.clear();
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

    getDirections(); //fetch direction polylines from Google API
  }

  initMapLocationList() async {
    setState(() {
      mapLocationListLoading = true;
    });

    mapLocationList.clear();
    mapLocationList = await mapLocationApi.getMapList(checkUrl: true);

    setState(() {
      mapLocationListLoading = false;
    });
  }

  getDirections() async {
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
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PAGE HITUNG JARAK BRO"),
        backgroundColor: nunutPrimaryColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            markers: markers, //markers to show on map
            polylines: Set<Polyline>.of(polylines.values), //polylines
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),
          Positioned(
            bottom: 200,
            left: 50,
            child: Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Total Distance: " + distance.toStringAsFixed(2) + " KM",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            child: mapLocationListLoading
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: DropdownButton(
                      hint: Text("Pilih Lokasi Awal"),
                      value: chosenMapLocation.isEmpty ? null : mapLocationList.firstWhere((element) => element.name == chosenMapLocation),
                      items: mapLocationList.map((MapLocation mapLocation) {
                        return DropdownMenuItem(
                          child: Text(mapLocation.name!),
                          value: mapLocation,
                        );
                      }).toList(),
                      onChanged: (MapLocation? value) {
                        setState(() {
                          endLocation = LatLng(double.parse(value!.latitude), double.parse(value.longitude));
                          chosenMapLocation = value.name!;
                          startCalculate();
                        });
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
