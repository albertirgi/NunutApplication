import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/screens/mapList.dart';
import 'package:nunut_application/screens/rideBookDetail.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/twoColumnView.dart';
import 'package:google_maps_webservice/places.dart';

import '../models/mrideschedule.dart';
import '../theme.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: config.googleAPiKey);

class RideShare extends StatefulWidget {
  bool fromUKP;
  RideShare({super.key, required this.fromUKP});

  @override
  State<RideShare> createState() => _RideShareState();
}

class _RideShareState extends State<RideShare> {
  List<RideSchedule> rideScheduleList = [];
  List<RideSchedule> rideSchedulePageList = [];
  int _page = 0;
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool isSearch = false;
  bool? rideScheduleListLoading;
  bool isLoading = false;
  bool done = false;
  Set<Marker> markers = Set();
  LatLng? showLocation;
  GoogleMapController? mapController;
  ScrollController? _scrollController;
  String buildingName = "";
  // Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    // buildingName = config.selectedBuilding!.replaceAll(" ", "");
    initRideScheduleList();
    // _getCurrentPosition();
    _scrollController = ScrollController();
    _scrollController!.addListener(scrollListener);
    widget.fromUKP
        ? pickUpController.text = "Universitas Kristen Petra"
        : destinationController.text = "Universitas Kristen Petra";
  }

  void dispose() {
    _scrollController!.removeListener(scrollListener);
    _scrollController!.dispose();
    super.dispose();
  }

  initRideScheduleList({String tempParameter = ""}) async {
    setState(() {
      rideScheduleListLoading = true;
      _page = 1;
    });

    // tempParameter.isNotEmpty ? tempParameter += "&" : tempParameter += "";
    String initialParameter = widget.fromUKP
        ? "user=${config.user.id}&driver&vehicle&meeting_point=UniversitasKristenPetra"
        : "user=${config.user.id}&driver&vehicle&destination=UniversitasKristenPetra";
    tempParameter = initialParameter + tempParameter;

    rideScheduleList.clear();
    rideScheduleList = await rideScheduleApi.getRideScheduleList(
      parameter: tempParameter,
      // page: _page,
      checkUrl: true,
    );

    setState(() {
      rideScheduleListLoading = false;
      _page++;
    });
  }

  loadmore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      rideSchedulePageList.clear();
      rideSchedulePageList = await rideScheduleApi.getRideScheduleList(
        parameter: widget.fromUKP
            ? "user=${config.user.id}&driver&vehicle&meeting_point=UniversitasKristenPetra"
            : "user=${config.user.id}&driver&vehicle&destination=UniversitasKristenPetra",
        // page: _page,
        checkUrl: true,
      );
      _page++;

      rideScheduleList.addAll(rideSchedulePageList);
      if (rideSchedulePageList.length < 10 || rideSchedulePageList.isEmpty) {
        done = true;
      }

      setState(() {
        isLoading = false;
        _page = _page;
      });
    }
  }

  scrollListener() {
    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent - 100 &&
        !_scrollController!.position.outOfRange &&
        !done) {
      // loadmore();
    }
  }

  // Future<Null> displayPrediction(Prediction? p) async {
  //   if (p != null) {
  //     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

  //     var placeId = p.placeId;
  //     double lat = detail.result.geometry!.location.lat;
  //     double lng = detail.result.geometry!.location.lng;

  //     var address = await Geocoder.local.findAddressesFromQuery(p.description);

  //     print("HALO" + lat.toString());
  //     print("HALO" + lng.toString());
  //   }
  // }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       showLocation = LatLng(position.latitude, position.longitude);
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  //   MakeMarker();
  // }

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
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Image(
                image:
                    AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
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
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   // margin:
                            //   //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(24),
                            //     color: Colors.white,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         spreadRadius: 2,
                            //         blurRadius: 5,
                            //         offset: Offset(0, 0), // changes position of shadow
                            //       ),
                            //     ],
                            //   ),
                            //   child: IconButton(
                            //     icon: Icon(Icons.chat, color: Colors.black, size: 18),
                            //     onPressed: () {},
                            //   ),
                            // ),
                            // SizedBox(width: 10),
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
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.bookmark, color: Colors.black),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/rideBookmark')
                                      .then((value) => onGoBack(value));
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            //icon task
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   // margin:
                            //   //     EdgeInsets.only(top: 62, bottom: 10, right: 20),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(24),
                            //     color: Colors.white,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         spreadRadius: 2,
                            //         blurRadius: 5,
                            //         offset: Offset(0, 0), // changes position of shadow
                            //       ),
                            //     ],
                            //   ),
                            //   child: IconButton(
                            //     icon: Icon(Icons.task, color: Colors.black),
                            //     onPressed: () {},
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    NunutText(
                        title: "Hai, " + config.user.name,
                        fontWeight: FontWeight.bold),
                    NunutText(title: "Butuh \nTumpangan?", isTitle: true),
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
                                    child: Icon(Icons.circle,
                                        color: nunutPrimaryColor, size: 18),
                                  ),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.grey, size: 8),
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
                                      enabled: !widget.fromUKP,
                                      readOnly: true,
                                      controller: pickUpController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: 'Pilih Lokasi Jemput',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MapList(
                                              fromUKP: widget.fromUKP,
                                            ),
                                          ),
                                        );
                                        setState(() {
                                          pickUpController.text = result;
                                          print("Result: " + result);
                                        });
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => MapList(
                                        //       fromUKP: widget.fromUKP,
                                        //     ),
                                        //   ),
                                        // );
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
                                      enabled: widget.fromUKP,
                                      readOnly: true,
                                      controller: destinationController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: 'Pilih Lokasi Tujuan',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MapList(
                                              fromUKP: widget.fromUKP,
                                            ),
                                          ),
                                        );
                                        setState(() {
                                          destinationController.text = result;
                                        });
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => MapList(
                                        //       fromUKP: widget.fromUKP,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 230,
                                        height: 40,
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          controller: dateController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.black,
                                                size: 14),
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat.yMMMd()
                                                      .format(pickedDate);
                                              setState(() {
                                                dateController.text =
                                                    formattedDate;
                                              });
                                            }
                                            // print("Date: " + dateController.text);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      // Container(
                                      //   width: 110,
                                      //   height: 40,
                                      //   child: TextFormField(
                                      //     style: TextStyle(fontSize: 12),
                                      //     controller: timeController,
                                      //     decoration: InputDecoration(
                                      //       prefixIcon: Icon(Icons.timer, color: Colors.black, size: 14),
                                      //       contentPadding: EdgeInsets.only(left: 10),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[200],
                                      //       border: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(24),
                                      //         borderSide: BorderSide.none,
                                      //       ),
                                      //     ),
                                      //     onTap: () async {
                                      //       FocusScope.of(context).requestFocus(new FocusNode());
                                      //       TimeOfDay? picked = await showTimePicker(
                                      //         context: context,
                                      //         initialTime: TimeOfDay.now(),
                                      //       );
                                      //       if (picked != null) {
                                      //         setState(() {
                                      //           timeController.text = picked.format(context);
                                      //         });
                                      //       }
                                      //       // print("Time: " + timeController.text);
                                      //     },
                                      //   ),
                                      // ),
                                      SizedBox(width: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: nunutPrimaryColor,
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              isSearch = true;
                                            });
                                            String _parameter =
                                                await parameterController();
                                            initRideScheduleList(
                                                tempParameter: _parameter);
                                          },
                                          icon: Icon(
                                              Icons.arrow_right_alt_rounded),
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
                    rideScheduleListLoading!
                        ? Center(
                            heightFactor: 5,
                            child: CircularProgressIndicator(),
                          )
                        : rideScheduleList.isNotEmpty
                            ? Column(
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: rideScheduleList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RideBookDetail(
                                                rideSchedule:
                                                    rideScheduleList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: TwoColumnView(
                                          imagePath: rideScheduleList[index]
                                              .driver!
                                              .image,
                                          departureTime:
                                              rideScheduleList[index].time!,
                                          name: rideScheduleList[index]
                                              .driver!
                                              .name,
                                          destination: rideScheduleList[index]
                                              .destination!
                                              .name!,
                                          isBookmarked: rideScheduleList[index]
                                              .isBookmarked!,
                                          price: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: '',
                                            decimalDigits: 0,
                                          ).format(
                                              rideScheduleList[index].price),
                                          IconOnTap: () async {
                                            bool result;
                                            rideScheduleList[index]
                                                    .isBookmarked!
                                                ? result = await rideScheduleApi
                                                    .deleteBookmarkByRideScheduleId(
                                                        rideScheduleId:
                                                            rideScheduleList[
                                                                    index]
                                                                .id!,
                                                        userId: config.user.id!,
                                                        checkUrl: true)
                                                : result = await rideScheduleApi
                                                    .updateBookmark(
                                                        rideScheduleId:
                                                            rideScheduleList[
                                                                    index]
                                                                .id!,
                                                        userId:
                                                            config.user.id!);
                                            if (result) {
                                              rideScheduleList[index]
                                                      .isBookmarked =
                                                  !rideScheduleList[index]
                                                      .isBookmarked!;
                                              if (rideScheduleList[index]
                                                  .isBookmarked!) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Berhasil menambahkan ke bookmark');
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Berhasil menghapus dari bookmark');
                                              }
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Container(),
                                  SizedBox(height: 20),
                                ],
                              )
                            : Center(
                                heightFactor: 5,
                                child: Column(
                                  children: [
                                    NunutText(
                                        title: "Tumpangan tidak tersedia",
                                        color: Colors.grey,
                                        size: 16,
                                        fontWeight: FontWeight.w500),
                                    NunutText(
                                        title: "Mohon ubah kolom pencarian",
                                        color: Colors.grey,
                                        size: 16,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String parameterController() {
    String _parameter = "";
    DateTime dateTime;

    if (dateController.text.isNotEmpty) {
      dateTime = DateFormat.yMMMd().parse(dateController.text);
      final tempMillisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
      _parameter += "&time=${tempMillisecondsSinceEpoch.toString()}";
    }

    widget.fromUKP
        ? destinationController.text.isNotEmpty
            ? _parameter +=
                "&destination=${destinationController.text.replaceAll(" ", "")}"
            // ? print("destination: ${destinationController.text.replaceAll(" ", "")}")
            : _parameter += ""
        : pickUpController.text.isNotEmpty
            ? _parameter +=
                "&meeting_point=${pickUpController.text.replaceAll(" ", "")}"
            : _parameter += "";

    print("parameter: $_parameter");

    return _parameter;
  }

  onRefresh() async {
    rideScheduleListLoading = true;
    done = false;
    _page = 1;
    rideSchedulePageList.clear();
    rideScheduleList.clear();
    await initRideScheduleList();
  }
}
