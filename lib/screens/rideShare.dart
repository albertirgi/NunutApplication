import 'dart:async';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/resources/mapLocationApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/twoColumnView.dart';
import 'package:google_maps_webservice/places.dart';

import '../models/mrideschedule.dart';
import '../theme.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: config.googleAPiKey);

class rideShare extends StatefulWidget {
  const rideShare({super.key});

  @override
  State<rideShare> createState() => _rideShareState();
}

class _rideShareState extends State<rideShare> {
  List<RideSchedule> rideScheduleList = [];
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool isSearch = false;
  bool? rideScheduleListLoading;
  String? _currentAddress;
  Position? _currentPosition;
  Set<Marker> markers = Set();
  LatLng? showLocation;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    initRideScheduleList();
    _getCurrentPosition();
  }

  initRideScheduleList() async {
    setState(() {
      rideScheduleListLoading = true;
    });

    rideScheduleList.clear();
    rideScheduleList = await rideScheduleApi.getRideScheduleList(parameter: "user=${config.user.id}&driver", checkUrl: true);

    setState(() {
      rideScheduleListLoading = false;
    });
  }

  Future<Null> displayPrediction(Prediction? p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

      var placeId = p.placeId;
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print("HALO" + lat.toString());
      print("HALO" + lng.toString());
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
        showLocation = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      debugPrint(e);
    });
    MakeMarker();
  }

  void MakeMarker() {
    markers.add(
      Marker(
        //add marker on google map
        markerId: MarkerId(showLocation.toString()),
        position: showLocation!, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Your Location ',
          snippet: 'You are here',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ),
    );
  }

  Widget buildCustomPrefixIcon(IconData iconData) {
    return Container(
      width: 0,
      alignment: Alignment(-0.99, 0.0),
      child: Icon(iconData),
    );
  }

  FutureOr onGoBack(dynamic value) {
    initRideScheduleList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          rideScheduleListLoading = true;
          await initRideScheduleList();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Image(
                image: AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        //icon chat
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              // margin:
                              //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.chat, color: Colors.black, size: 18),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
                              // margin:
                              //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.bookmark, color: Colors.black),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/rideBookmark').then((value) => onGoBack(value));
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            //icon task
                            Container(
                              width: 40,
                              height: 40,
                              // margin:
                              //     EdgeInsets.only(top: 62, bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.task, color: Colors.black),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    NunutText(title: "Hai, Grace", fontWeight: FontWeight.bold),
                    BorderedText(
                      child: Text(
                        "Butuh\nTumpangan?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                      strokeWidth: 3.0,
                      strokeColor: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, bottom: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.0),
                                    child: Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
                                  ),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.blueAccent[100],
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              // margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: NunutText(
                                      title: "Lokasi Jemput",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 290,
                                    height: 40,
                                    child: TextFormField(
                                      controller: pickUpController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 20),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(24),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onTap: () async {
                                        Prediction? p = await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: config.googleAPiKey,
                                          mode: Mode.fullscreen,
                                          language: "id",
                                          strictbounds: false,
                                          types: ["(address)"],
                                          components: [Component(Component.country, "id")],
                                        );
                                        displayPrediction(p);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: NunutText(
                                      title: "Lokasi Tujuan",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 290,
                                    height: 40,
                                    child: TextFormField(
                                      controller: destinationController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 20),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(24),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 115,
                                        height: 40,
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          controller: dateController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.calendar_today, color: Colors.black, size: 14),
                                            contentPadding: EdgeInsets.only(left: 10),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(24),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          onTap: () async {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                              setState(() {
                                                dateController.text = formattedDate; //set output date to TextField value.
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 110,
                                        height: 40,
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          controller: timeController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.timer, color: Colors.black, size: 14),
                                            contentPadding: EdgeInsets.only(left: 10),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(24),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          onTap: () async {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            TimeOfDay? picked = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (picked != null) {
                                              setState(() {
                                                timeController.text = picked.format(context);
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          color: nunutPrimaryColor,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isSearch = true;
                                            });
                                          },
                                          icon: Icon(Icons.arrow_right_alt_rounded),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                    // showLocation != null
                    //     ? Container(
                    //         height: 300,
                    //         width: double.infinity,
                    //         child: GoogleMap(
                    //           //Map widget from google_maps_flutter package
                    //           zoomGesturesEnabled: true, //enable Zoom in, out on map
                    //           initialCameraPosition: CameraPosition(
                    //             //innital position in map
                    //             target: showLocation!, //initial position
                    //             zoom: 10.0, //initial zoom level
                    //           ),
                    //           markers: markers, //markers to show on map
                    //           mapType: MapType.normal, //map type
                    //           onMapCreated: (controller) {
                    //             //method called when map is created
                    //             setState(() {
                    //               mapController = controller;
                    //             });
                    //           },
                    //         ),
                    //       )
                    //     :
                    // Container(
                    //   height: 300,
                    //   width: double.infinity,
                    //   child: GoogleMap(
                    //     //Map widget from google_maps_flutter package
                    //     zoomGesturesEnabled: true, //enable Zoom in, out on map
                    //     initialCameraPosition: CameraPosition(
                    //       //innital position in map
                    //       target: LatLng(-7.294105697050977, 112.73620614655268), //initial position
                    //       zoom: 10.0, //initial zoom level
                    //     ),
                    //     // markers: markers, //markers to show on map
                    //     mapType: MapType.normal, //map type
                    //     onMapCreated: (controller) {
                    //       //method called when map is created
                    //       setState(() {
                    //         mapController = controller;
                    //       });
                    //     },
                    //   ),
                    // ),
                    Visibility(
                      visible: isSearch,
                      child: rideScheduleListLoading!
                          ? Center(
                              heightFactor: 5,
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: rideScheduleList.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                return TwoColumnView(
                                  imagePath: rideScheduleList[index].driver!.image,
                                  departureTime: rideScheduleList[index].time!,
                                  name: rideScheduleList[index].driver!.name,
                                  destination: rideScheduleList[index].destination!.name!,
                                  isBookmarked: rideScheduleList[index].isBookmarked!,
                                  price: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: '',
                                    decimalDigits: 0,
                                  ).format(rideScheduleList[index].price),
                                  IconOnTap: () async {
                                    bool result;
                                    rideScheduleList[index].isBookmarked!
                                        ? result = await rideScheduleApi.deleteBookmarkByRideScheduleId(rideScheduleId: rideScheduleList[index].id!, userId: config.user.id!, checkUrl: true)
                                        : result = await rideScheduleApi.updateBookmark(rideScheduleId: rideScheduleList[index].id!, userId: config.user.id!);
                                    if (result) {
                                      rideScheduleList[index].isBookmarked = !rideScheduleList[index].isBookmarked!;
                                      print("BERHASIL");
                                    }
                                    setState(() {});
                                  },
                                );
                              },
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
