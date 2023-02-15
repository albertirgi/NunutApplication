import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nunut_application/models/mriderequest.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';

class RideDetail extends StatefulWidget {
  final String rideScheduleId;
  RideDetail({super.key, required this.rideScheduleId});

  @override
  State<RideDetail> createState() => _RideDetailState();
}

class _RideDetailState extends State<RideDetail> {
  RideSchedule rideSchedule = RideSchedule();
  List<RideRequest> rideRequestList = [];
  TextEditingController searchController = TextEditingController();
  bool rideScheduleLoading = true;
  // bool rideRequestListLoading = true;

  @override
  void initState() {
    super.initState();
    initRideScheduleDetail();
  }

  initRideScheduleDetail() async {
    setState(() {
      rideScheduleLoading = true;
    });

    rideSchedule = RideSchedule();
    rideSchedule = await rideScheduleApi.getRideScheduleById(id: widget.rideScheduleId, parameter: "driver&vehicle", checkUrl: true);
    await initRideRequestList();

    setState(() {
      rideScheduleLoading = false;
    });
  }

  initRideRequestList() async {
    // setState(() {
    //   rideRequestListLoading = true;
    // });

    rideRequestList.clear();
    rideRequestList = await rideRequestApi.getRideRequestList(rideScheduleId: widget.rideScheduleId, parameter: "user", checkUrl: true);

    // setState(() {
    //   rideRequestListLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[50],
      //   elevation: 0,
      //   toolbarHeight: 100,
      //   leading: Container(
      //     margin: EdgeInsets.only(top: 52),
      //     child: IconButton(
      //       icon: Icon(Icons.arrow_back, color: Colors.black),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle2.png'),
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100, left: 12),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 28, right: 28),
                  child: rideScheduleLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              period: Duration(milliseconds: 800),
                              child: Container(
                                height: 20,
                                width: Random().nextInt(60) + 150,
                                color: Colors.grey[200],
                              ),
                            ),
                            SizedBox(height: 20),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              period: Duration(milliseconds: 800),
                              child: Container(
                                height: 25,
                                width: Random().nextInt(60) + 150,
                                color: Colors.grey[200],
                              ),
                            ),
                            SizedBox(height: 10),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              period: Duration(milliseconds: 800),
                              child: Container(
                                height: 25,
                                width: Random().nextInt(50) + 100,
                                color: Colors.grey[200],
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: nunutPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.grey[350]!,
                                  period: Duration(milliseconds: 800),
                                  child: Container(
                                    height: 20,
                                    width: Random().nextInt(100) + 150,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 10,
                              child: Dash(
                                direction: Axis.vertical,
                                length: 15,
                                dashLength: 2,
                                dashColor: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: nunutBlueColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.grey[350]!,
                                  period: Duration(milliseconds: 800),
                                  child: Container(
                                    height: 20,
                                    width: Random().nextInt(100) + 150,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Divider(color: Colors.grey, thickness: 0.5),
                            SizedBox(height: 20),
                            NunutText(title: "Daftar Penumpang", fontWeight: FontWeight.bold, size: 16),
                            SizedBox(height: 20),
                            Container(
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Divider(color: Colors.grey, thickness: 0.5),
                            SizedBox(height: 10),
                            NunutText(title: "Tempat Parkir", fontWeight: FontWeight.bold, size: 16),
                            SizedBox(height: 5),
                            NunutText(title: "Yuk pesan tempat parkir sekarang!", fontWeight: FontWeight.w500, size: 14),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                NunutButton(
                                  title: "Pesan",
                                  textSize: 14,
                                  widthButton: 120,
                                  heightButton: 40,
                                  fontWeight: FontWeight.w600,
                                  borderColor: Colors.transparent,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/bookingParkir', arguments: widget.rideScheduleId);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            NunutText(
                              title: "Tumpangan NUNUT #XYD139",
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 10),
                            NunutText(
                              title: rideSchedule.date.toString(),
                              fontWeight: FontWeight.bold,
                              size: 22,
                            ),
                            NunutText(
                              title: "Pukul ${rideSchedule.time.toString()}",
                              fontWeight: FontWeight.bold,
                              size: 22,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: nunutPrimaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              child: NunutText(
                                                title: rideSchedule.meetingPoint!.name.toString(),
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 10,
                                        child: Dash(
                                          direction: Axis.vertical,
                                          length: 10,
                                          dashLength: 2,
                                          dashColor: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: nunutBlueColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: TextScroll(
                                              rideSchedule.destination!.name.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            NunutButton(
                              title: "Peta",
                              widthButton: 90,
                              heightButton: 35,
                              textSize: 14,
                              borderColor: Colors.transparent,
                              iconButton: Icon(Icons.map_outlined, color: Colors.black),
                              onPressed: () {},
                            ),
                            SizedBox(height: 16),
                            Divider(color: Colors.grey, thickness: 0.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NunutText(title: "Daftar Penumpang", fontWeight: FontWeight.bold, size: 16),
                                NunutButton(
                                  title: "Scan QR",
                                  textSize: 14,
                                  widthButton: 120,
                                  heightButton: 40,
                                  borderColor: Colors.transparent,
                                  iconButton: Icon(
                                    Icons.qr_code_scanner_outlined,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/qrCode');
                                    //Navigator.pushNamed(context, '/qrCode').then((value) => onGoBack(value));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            rideRequestList.isEmpty
                                ? Container(
                                    height: 100,
                                    child: Center(
                                      child: NunutText(title: "Belum ada penumpang", fontWeight: FontWeight.w500, size: 14, color: Colors.grey),
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // CircleAvatar(
                                          //   radius: 20,
                                          //   backgroundImage: NetworkImage(
                                          //     "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
                                          //   ),
                                          // ),
                                          // SizedBox(width: 10),
                                          NunutText(title: rideRequestList[index].user!.name, fontWeight: FontWeight.w500, size: 14),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  index % 2 == 1 ? Icons.check_circle_outline : Icons.cancel_outlined,
                                                  size: 30,
                                                  color: index % 2 == 1 ? Colors.green : Colors.red,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 10);
                                    },
                                    itemCount: rideRequestList.length,
                                  ),
                            SizedBox(height: 10),
                            Divider(color: Colors.grey, thickness: 0.5),
                            SizedBox(height: 10),
                            NunutText(title: "Tempat Parkir", fontWeight: FontWeight.bold, size: 16),
                            SizedBox(height: 5),
                            NunutText(title: "Yuk pesan tempat parkir sekarang!", fontWeight: FontWeight.w500, size: 14),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                NunutButton(
                                  title: "Pesan",
                                  textSize: 14,
                                  widthButton: 120,
                                  heightButton: 40,
                                  fontWeight: FontWeight.w600,
                                  borderColor: Colors.transparent,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/bookingParkir', arguments: widget.rideScheduleId);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                ),
                SizedBox(height: 60),
                Container(
                  color: nunutPrimaryColor,
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 40,
                        margin: EdgeInsets.zero,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NunutText(
                                title: "Perjalanan Selesai",
                                color: Colors.white,
                                size: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            elevation: 0.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/pengaduanKendala');
                        },
                        child: NunutText(
                          title: "Ada masalah dengan perjalanan?",
                          fontWeight: FontWeight.w500,
                          size: 12,
                          color: Colors.black,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
