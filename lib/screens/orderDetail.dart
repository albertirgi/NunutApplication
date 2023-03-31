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

class OrderDetail extends StatefulWidget {
  final String rideScheduleId;
  OrderDetail({super.key, required this.rideScheduleId});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
    rideSchedule = await rideScheduleApi.getRideScheduleById(id: widget.rideScheduleId, parameter: "driver&vehicle");
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
    rideRequestList = await rideRequestApi.getRideRequestList(rideScheduleId: widget.rideScheduleId, parameter: "user");

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
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
