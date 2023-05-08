import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nunut_application/models/mriderequest.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:nunut_application/widgets/popUpLoading.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool isUserAlreadyAbsent = true;

  @override
  void initState() {
    super.initState();
    initRideScheduleDetail();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  initRideScheduleDetail() async {
    setState(() {
      rideScheduleLoading = true;
    });

    rideSchedule = RideSchedule();
    rideSchedule = await rideScheduleApi.getRideScheduleById(id: widget.rideScheduleId, parameter: "driver&vehicle");
    await initRideRequestList();
    await checkUserAbsent();

    setState(() {
      rideScheduleLoading = false;
    });
  }

  initRideRequestList() async {
    rideRequestList.clear();
    rideRequestList = await rideRequestApi.getRideRequestList(rideScheduleId: widget.rideScheduleId, parameter: "user");
  }

  checkUserAbsent() {
    isUserAlreadyAbsent = false;
    for (var i = 0; i < rideRequestList.length; i++) {
      if (rideRequestList[i].status == "ONGOING") {
        isUserAlreadyAbsent = true;
      }
    }
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
    checkUserAbsent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 150,
        color: nunutPrimaryColor,
        padding: EdgeInsets.only(top: isUserAlreadyAbsent ? 50 : 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 40,
              margin: EdgeInsets.zero,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return PopUpLoading(
                        title: "Konfirmasi",
                        subtitle: "Apakah anda yakin ingin menyelesaikan perjalanan?",
                        isConfirmation: true,
                      );
                    },
                  ).then((value) {
                    if (value == true) {
                      RideScheduleApi.rideScheduleDone(rideScheduleId: widget.rideScheduleId, checkUrl: true).then((value) {
                        if (value) {
                          Fluttertoast.showToast(msg: "Perjalanan selesai");
                          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                        } else {
                          Fluttertoast.showToast(msg: "Gagal menyelesaikan perjalanan");
                        }
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Gagal menyelesaikan perjalanan");
                    }
                  });
                },
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
              onTap: () async {
                await initRideRequestList();
                if (!rideSchedule.isActive!) {
                  Fluttertoast.showToast(msg: "Tumpangan sudah selesai, tidak bisa dibatalkan");
                  return;
                }
                Navigator.pushNamed(context, '/pengaduanKendala', arguments: {
                  'title': 'Pembatalan Tumpangan',
                  'isiTitle': 'Pembatalan Tumpangan',
                  'lockTitle': 'true',
                  'ride_schedule_id': rideSchedule.id,
                });
              },
              child: !isUserAlreadyAbsent
                  ? NunutText(
                      title: "Ingin membatalkan tumpangan ?",
                      fontWeight: FontWeight.w500,
                      size: 12,
                      color: Colors.black,
                      textDecoration: TextDecoration.underline,
                    )
                  : Container(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/backgroundCircle/backgroundCircle2.png'),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 12),
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
                                  Expanded(
                                    child: Column(
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
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              height: 20,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: NunutScrollText(
                                                  title: rideSchedule.meetingPoint!.name.toString(),
                                                  textAlign: TextAlign.center,
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
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: NunutScrollText(
                                                  title: rideSchedule.destination!.name.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                rideRequestList.length > 1
                                    ? NunutButton(
                                        title: "Book Parkir",
                                        iconButton: Icon(
                                          FontAwesomeIcons.squareParking,
                                          color: Colors.black,
                                        ),
                                        widthButton: 140,
                                        heightButton: 35,
                                        onPressed: () {
                                          launchUrl(Uri.parse("https://docs.google.com/forms/d/e/1FAIpQLSdw9J9tls5ebdaByw6DvK5LnCfnYFVWYgsdsgN2YzWqDDH89g/viewform?usp=sf_link"));
                                        },
                                      )
                                    : Container(),
                              ],
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
                                    Navigator.pushNamed(context, '/qrCode').then((value) => onGoBack(value));
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
                                          NunutText(title: rideRequestList[index].user!.name, fontWeight: FontWeight.w500, size: 14),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  rideRequestList[index].status == "ONGOING" ? Icons.check_circle_outline : Icons.cancel_outlined,
                                                  size: 30,
                                                  color: rideRequestList[index].status == "ONGOING" ? Colors.green : Colors.red,
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
                            SizedBox(height: 30),
                          ],
                        ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    rideScheduleLoading = true;
    rideSchedule = RideSchedule();
    rideRequestList.clear();
    await initRideScheduleDetail();
  }
}
