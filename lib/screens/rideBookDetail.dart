import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/screens/payment.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:shimmer/shimmer.dart';

class RideBookDetail extends StatefulWidget {
  String rideScheduleId;
  RideBookDetail({super.key, required this.rideScheduleId});

  @override
  State<RideBookDetail> createState() => _RideBookDetailState();
}

class _RideBookDetailState extends State<RideBookDetail> {
  int availableSeat = 0;
  RideSchedule rideSchedule = RideSchedule();
  bool isBookmarking = false;
  bool rideScheduleLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRideScheduleDetail();
  }

  initRideScheduleDetail() async {
    setState(() {
      rideScheduleLoading = true;
    });

    rideSchedule = RideSchedule();
    rideSchedule = await rideScheduleApi.getRideScheduleById(id: widget.rideScheduleId, parameter: "user_view=true&ride_request&user=${config.user.id}&driver&vehicle", checkUrl: true);
    availableSeat = rideSchedule.capacity! - rideSchedule.rideRequest!.length;

    setState(() {
      rideScheduleLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Column(
        children: [
          SizedBox(height: 24),
          NunutText(title: "NUNUT SAMA"),
          NunutText(
            title: rideSchedule.driver.name,
            fontWeight: FontWeight.bold,
            size: 35,
          ),
          NunutText(title: "${rideSchedule.vehicle.transportationType} | ${rideSchedule.vehicle.licensePlate}"),
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: NunutText(title: "TANGGAL", size: 12),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(title: "JAM BERANGKAT", size: 12),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: NunutText(title: rideSchedule.date.toString(), maxLines: 2, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(title: rideSchedule.time.toString(), maxLines: 2, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: NunutText(title: "MEETING POINT", size: 12),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(title: "DESTINATION POINT", size: 12),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: NunutText(title: rideSchedule.meetingPoint!.name!.toString(), maxLines: 2, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(title: rideSchedule.destination!.name!, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: NunutText(title: "KAPASITAS TERSISA", size: 12),
                    ),
                    Expanded(
                      child: NunutText(title: "HARGA", size: 12),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: NunutText(title: availableSeat.toString(), fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: NunutText(
                        title: "IDR " + calculateMinimumPrice(rideSchedule.price.toString(), rideSchedule.capacity!) + " - " + priceFormat(rideSchedule.price.toString()),
                        fontWeight: FontWeight.bold,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: NunutText(
                        title: "* Harga bervariasi mengikuti total penumpang",
                        size: 12,
                        color: Colors.red,
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          NunutButton(
            widthButton: 200,
            heightButton: 45,
            borderColor: Colors.white,
            title: "Nunut!",
            fontWeight: FontWeight.bold,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    content: Material(
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close),
                              ),
                            ),
                            NunutText(title: "Anda akan memesan perjalanan : ", fontWeight: FontWeight.bold),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.date_range_outlined),
                                SizedBox(width: 8),
                                NunutText(title: rideSchedule.date.toString()),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.timeline),
                                SizedBox(width: 8),
                                NunutText(title: rideSchedule.time.toString()),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.location_city_outlined),
                                SizedBox(width: 8),
                                Expanded(
                                  child: NunutText(title: "${rideSchedule.meetingPoint!.name} - ${rideSchedule.destination!.name}"),
                                )
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 8),
                                NunutText(title: rideSchedule.driver.name),
                              ],
                            ),
                            SizedBox(height: 16),
                            NunutButton(
                              title: "Konfirmasi",
                              heightButton: 40,
                              widthButton: 175,
                              borderColor: Colors.white,
                              widthBorder: 0,
                              fontWeight: FontWeight.bold,
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Payment(
                                      rideSchedule: rideSchedule,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/lingkaranKuning_1.png",
                width: MediaQuery.of(context).size.width * 0.725,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.085,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            !rideScheduleLoading
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey,
                                spreadRadius: 0.1,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 110,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(rideSchedule.driver.image),
                              radius: 100,
                            ), //CircleAvatar
                          ),
                        ),
                        content(),
                      ],
                    ),
                  )
                // shimmer loading
                : Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey,
                                spreadRadius: 0.1,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 110,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              period: Duration(milliseconds: 800),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 24),
                            NunutText(title: "NUNUT SAMA"),
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
                            SizedBox(height: 32),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: NunutText(title: "TANGGAL", size: 12),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: NunutText(title: "JAM BERANGKAT", size: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[350]!,
                                      period: Duration(milliseconds: 800),
                                      child: Container(
                                        height: 20,
                                        width: Random().nextInt(60) + 70,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[350]!,
                                      period: Duration(milliseconds: 800),
                                      child: Container(
                                        height: 20,
                                        width: Random().nextInt(60) + 70,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: NunutText(title: "MEETING POINT", size: 12),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: NunutText(title: "DESTINATION POINT", size: 12),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[350]!,
                                      period: Duration(milliseconds: 800),
                                      child: Container(
                                        height: 20,
                                        width: Random().nextInt(60) + 70,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[350]!,
                                      period: Duration(milliseconds: 800),
                                      child: Container(
                                        height: 20,
                                        width: Random().nextInt(60) + 70,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: NunutText(title: "KAPASITAS TERSISA", size: 12),
                                      ),
                                      Expanded(
                                        child: NunutText(title: "HARGA", size: 12),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[350]!,
                                          period: Duration(milliseconds: 800),
                                          child: Container(
                                            height: 20,
                                            width: Random().nextInt(60) + 100,
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[350]!,
                                          period: Duration(milliseconds: 800),
                                          child: Container(
                                            height: 20,
                                            width: Random().nextInt(60) + 100,
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32),
                            NunutButton(
                              widthButton: 200,
                              heightButton: 45,
                              isDisabled: true,
                              borderColor: Colors.white,
                              title: "Nunut!",
                              fontWeight: FontWeight.bold,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.115,
                  right: MediaQuery.of(context).size.width * 0.26,
                ),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: !isBookmarking && !rideScheduleLoading
                      ? () async {
                          setState(() {
                            isBookmarking = true;
                          });
                          bool result;
                          rideSchedule.isBookmarked!
                              ? result = await rideScheduleApi.deleteBookmarkByRideScheduleId(rideScheduleId: rideSchedule.id!, userId: config.user.id!)
                              : result = await rideScheduleApi.updateBookmark(rideScheduleId: rideSchedule.id!, userId: config.user.id!);
                          if (result) {
                            rideSchedule.isBookmarked = !rideSchedule.isBookmarked!;
                            if (rideSchedule.isBookmarked!) {
                              Fluttertoast.showToast(msg: 'Berhasil menambahkan ke bookmark');
                            } else {
                              Fluttertoast.showToast(msg: 'Berhasil menghapus dari bookmark');
                            }
                          }
                          setState(() {
                            isBookmarking = false;
                          });
                        }
                      : null,
                  icon: Icon(
                    rideSchedule.isBookmarked! && !rideScheduleLoading ? Icons.bookmark : Icons.bookmark_border,
                    color: rideSchedule.isBookmarked! && !rideScheduleLoading ? nunutPrimaryColor : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
