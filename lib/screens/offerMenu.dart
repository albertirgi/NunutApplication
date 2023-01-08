import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/couponCard.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutCard.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';

class OfferMenu extends StatefulWidget {
  const OfferMenu({super.key});

  @override
  State<OfferMenu> createState() => _OfferMenuState();
}

class _OfferMenuState extends State<OfferMenu> {
  int _selectedNavbar = 0;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _meetingPointController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  int _capacityValue = 1;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      print("Selected index : {$_selectedNavbar}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget buildContent(int currentIndex) {
    //   switch (currentIndex) {
    //     case 0:
    //       return const HomePage();
    //     case 1:
    //       return const TransactionPage();
    //     case 2:
    //       return const ProfilePage();
    //     default:
    //       return const HomePage();
    //   }
    // }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: nunutPrimaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 52, left: 28, right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(
                  title: "Hai, Grace",
                  fontWeight: FontWeight.bold,
                ),
                BorderedText(
                  child: Text(
                    "Yuk tawarkan tumpangan!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  strokeWidth: 3.0,
                  strokeColor: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.money_outlined),
                      NunutText(
                        title: "IDR 50.000",
                        fontWeight: FontWeight.bold,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 50,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/rideList', arguments: true);
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height ,
                                        minHeight:
                                            MediaQuery.of(context).size.height *
                                                0.60,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.60,
                                      padding: EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: GestureDetector(
                                              child: Container(
                                                width: 50,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              onVerticalDragUpdate: (details) {
                                                int sensitivity = 8;
                                                if (details.delta.dy >
                                                    sensitivity) {
                                                  // Down Swipe
                                                } else if (details.delta.dy <
                                                    -sensitivity) {
                                                  // Up Swipe
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          NunutText(
                                            title: "Buat Tumpangan Baru",
                                            color: Colors.black,
                                            size: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NunutText(
                                                      title:
                                                          "Tanggal Berangkat",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 12,
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                      cursorColor: Colors.black,
                                                      obscureText: false,
                                                      controller:
                                                          _dateController,
                                                      onTap: () async {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                        DateTime? pickedDate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        2101));

                                                        if (pickedDate !=
                                                            null) {
                                                          String formattedDate =
                                                              DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(
                                                                      pickedDate);
                                                          setState(() {
                                                            _dateController
                                                                    .text =
                                                                formattedDate; //set output date to TextField value.
                                                          });
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                        isDense: true,
                                                        hintText: "dd/mm/yyyy",
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[300],
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NunutText(
                                                      title: "Jam Berangkat",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 12,
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                      cursorColor: Colors.black,
                                                      obscureText: false,
                                                      controller:
                                                          _timeController,
                                                      onTap: () async {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                        TimeOfDay? picked =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (picked != null) {
                                                          setState(() {
                                                            _timeController
                                                                    .text =
                                                                picked.format(
                                                                    context);
                                                          });
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                        isDense: true,
                                                        hintText: "00:00",
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[300],
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          NunutText(
                                            title: "Meeting Point",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          SizedBox(height: 10),
                                          Stack(
                                            children: [
                                              TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                                cursorColor: Colors.black,
                                                obscureText: false,
                                                controller:
                                                    _meetingPointController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                  isDense: true,
                                                  hintText:
                                                      "Pilih meeting pointmu...",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.grey[300],
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          NunutText(
                                            title: "Tujuan Destinasi",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          SizedBox(height: 10),
                                          Stack(
                                            children: [
                                              TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                                cursorColor: Colors.black,
                                                obscureText: false,
                                                controller: _destinationController,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      horizontal: 10, vertical: 10),
                                                  isDense: true,
                                                  hintText: "Pilih tujuan destinasimu...",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.grey[300],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(50),
                                                    borderSide: const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(50),
                                                    borderSide: const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NunutText(
                                                      title: "Kendaraan",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 12,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey[300],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                            "assets/toyota.png",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              NunutText(
                                                                title:
                                                                    "Toyota Innova",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                size: 10,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  NunutText(
                                                                    title:
                                                                        "L 8080 AZ",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    size: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  NunutButton(
                                                                    widthButton:
                                                                        55,
                                                                    widthBorder:
                                                                        0.0,
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    heightButton:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    title:
                                                                        "Ubah",
                                                                    textSize: 8,
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NunutText(
                                                      title: "Kapasitas",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 12,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (_capacityValue >
                                                                  1) {
                                                                _capacityValue =
                                                                    _capacityValue -
                                                                        1;
                                                              }
                                                            });
                                                          },
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.black),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            backgroundColor:
                                                                nunutPrimaryColor,
                                                            shape:
                                                                CircleBorder(),
                                                          ),
                                                        ),
                                                        NunutText(
                                                            title:
                                                                _capacityValue
                                                                    .toString(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            size: 14),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _capacityValue =
                                                                  _capacityValue +
                                                                      1;
                                                            });
                                                          },
                                                          child: Icon(Icons.add,
                                                              color:
                                                                  Colors.black),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            backgroundColor:
                                                                nunutPrimaryColor,
                                                            shape:
                                                                CircleBorder(),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 40),
                                          Align(
                                            alignment: Alignment.center,
                                            child: NunutButton(
                                              title: "Buat",
                                              onPressed: () async {
                                                var postRideScheduleStatus = await  RideScheduleApi.PostRideSchedule(
                                                  _dateController.text.toString(), 
                                                  _timeController.text.toString(), 
                                                  "112.73747806931482", 
                                                  "-7.338620797269136", 
                                                  "7.344542569968449", 
                                                  "112.73747806931482",
                                                  "vehicle_id",
                                                  _capacityValue.toString(), 
                                                  "driver_id",
                                                  );
                                                  
                                                //log("status :" + postRideScheduleStatus.toString());
                                                if(postRideScheduleStatus == true){
                                                  Fluttertoast.showToast(
                                                    msg: "Berhasil membuat jadwal",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                  );
                                                  setState(() {
                                                    _dateController.text = "";
                                                    _timeController.text = "";
                                                    _meetingPointController.text = "";
                                                    _destinationController.text = "";
                                                    _capacityValue = 1;
                                                  });
                                                }
                                                else{
                                                  Fluttertoast.showToast(
                                                    msg: "Gagal membuat jadwal",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                  );
                                                }
                                              },
                                              heightButton: 35,
                                              widthButton: 110,
                                              fontWeight: FontWeight.w500,
                                              widthBorder: 0.0,
                                              borderColor: Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NunutText(
                              title: "Tawarkan",
                              fontWeight: FontWeight.bold,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: nunutPrimaryColor,
                            ),
                            child: Icon(
                              Icons.people_sharp,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NunutText(
                            title: "Tumpanganku",
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: nunutPrimaryColor,
                            ),
                            child: Icon(
                              Icons.chat_bubble,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NunutText(
                            title: "Chat",
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: nunutPrimaryColor,
                            ),
                            child: Icon(
                              Icons.car_crash,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NunutText(
                            title: "Kendaraanku",
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.car_crash),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.route),
                label: "Transaction",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedNavbar,
            selectedItemColor: Colors.yellowAccent,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: _changeSelectedNavBar,
          ),
        ),
      ),
    );
  }
}
