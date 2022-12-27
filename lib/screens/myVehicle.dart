import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutCard.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class MyVehicle extends StatefulWidget {
  const MyVehicle({super.key});

  @override
  State<MyVehicle> createState() => _MyVehicleState();
}

class _MyVehicleState extends State<MyVehicle> {
  TextEditingController _vehicleTypeController = TextEditingController();
  TextEditingController _licensePlateController = TextEditingController();
  TextEditingController _expiredDateController = TextEditingController();
  TextEditingController _vehicleColorController = TextEditingController();
  TextEditingController _vehicleNoteController = TextEditingController();
  bool _isMainVehicle = false;
  List<AssetImage> images = <AssetImage>[
    AssetImage("assets/toyota.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        toolbarHeight: 100,
        leading: Container(
          margin: EdgeInsets.only(top: 52),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 12, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedText(
                child: Text(
                  "Kendaraanku",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                strokeWidth: 3.0,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 30),
              Container(
                width: 240,
                height: 40,
                margin: EdgeInsets.zero,
                child: ElevatedButton(
                  onPressed: () {
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
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.53,
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: GestureDetector(
                                    child: Container(
                                      width: 50,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                    onVerticalDragUpdate: (details) {
                                      int sensitivity = 8;
                                      if (details.delta.dy > sensitivity) {
                                        // Down Swipe
                                      } else if (details.delta.dy <
                                          -sensitivity) {
                                        // Up Swipe
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                NunutText(
                                  title: "Tambah Kendaraan Baru",
                                  color: Colors.black,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 20),
                                NunutText(
                                  title: "Jenis Kendaraan",
                                  fontWeight: FontWeight.bold,
                                  size: 12,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  cursorColor: Colors.black,
                                  obscureText: false,
                                  controller: _vehicleTypeController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    isDense: true,
                                    hintText:
                                        "e.g. Honda Jazz, Toyota Avanza, etc.",
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
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NunutText(
                                            title: "Nomor Plat",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            cursorColor: Colors.black,
                                            obscureText: false,
                                            controller: _licensePlateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              isDense: true,
                                              hintText: "e.g. L 1234 XX",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[300],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NunutText(
                                            title: "Berlaku Hingga",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            cursorColor: Colors.black,
                                            obscureText: false,
                                            controller: _licensePlateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              isDense: true,
                                              hintText: "e.g. 11/2024",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[300],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NunutText(
                                            title: "Warna",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            cursorColor: Colors.black,
                                            obscureText: false,
                                            controller: _licensePlateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              isDense: true,
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[300],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NunutText(
                                            title: "Catatan",
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ),
                                          TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            cursorColor: Colors.black,
                                            obscureText: false,
                                            controller: _licensePlateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              isDense: true,
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[300],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    RoundCheckBox(
                                      checkedColor: Colors.black,
                                      checkedWidget: Container(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      size: 20,
                                      isChecked: _isMainVehicle,
                                      onTap: (value) {
                                        setState(
                                          () {
                                            _isMainVehicle = !_isMainVehicle;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    NunutText(
                                      title: "Jadikan Kendaraan Utama",
                                      color: Colors.black,
                                      size: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: NunutButton(
                                    title: "Tambah",
                                    onPressed: () {},
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      NunutText(
                        title: "Tambah Kendaraan",
                        color: Colors.black,
                        size: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    elevation: 0.0,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 0, left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      "assets/toyota.png",
                                      width: 70,
                                      height: 70,
                                    ),
                                    Column(
                                      children: [
                                        NunutText(
                                          title: "Toyota Avanza",
                                          color: Colors.black,
                                          size: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        NunutText(
                                          title: "L 8080 AZ",
                                          color: Colors.black,
                                          size: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NunutText(
                                  title: "KENDARAAN UTAMA",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: 1),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
