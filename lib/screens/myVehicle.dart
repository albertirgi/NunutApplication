import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:nunut_application/models/mvehicle.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../resources/vehicleApi.dart';

class MyVehicle extends StatefulWidget {
  const MyVehicle({super.key});

  @override
  State<MyVehicle> createState() => _MyVehicleState();
}

class _MyVehicleState extends State<MyVehicle> {
  List<Vehicle2> vehicles = <Vehicle2>[];
  bool isDataLoaded = false;
  List<AssetImage> images = <AssetImage>[
    AssetImage("assets/toyota.png"),
  ];

  @override
  void initState() {
    super.initState();
    VehicleApi.getVehicles().then((value) {
      setState(() {
        vehicles = value;
        isDataLoaded = true;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
  }

  onRefresh() {
    isDataLoaded = false;
    vehicles.clear();
    VehicleApi.getVehicles().then((value) {
      setState(() {
        vehicles = value;
        isDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            //topright
            top: 0,
            right: 0,
            child: Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle3.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                NunutText(title: "Kendaraanku", size: 32, isTitle: true),
                SizedBox(height: 30),
                Container(
                  width: 240,
                  height: 40,
                  margin: EdgeInsets.zero,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/addVehicle');
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
                isDataLoaded
                    ? vehicles.length == 0
                        ? Container(
                            margin: EdgeInsets.only(top: 70),
                            child: Center(
                              child: NunutText(title: "Data tidak ditemukan", size: 18, color: Colors.grey),
                            ),
                          )
                        : vehicleList(vehicles)
                    : Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(
                          color: nunutPrimaryColor,
                          strokeWidth: 2,
                        ),
                      ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleList(List<Vehicle2> vehicles) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Image.asset(
                              "assets/car.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            NunutText(
                              title: vehicles[index].transportationType ?? "",
                              color: Colors.black,
                              size: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            NunutText(
                              title: vehicles[index].licensePlate ?? "",
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
              vehicles[index].isMain!
                  ? Container(
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
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NunutText(
                            title: "",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
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
                    ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 12);
      },
      itemCount: vehicles.length,
    );
  }
}
