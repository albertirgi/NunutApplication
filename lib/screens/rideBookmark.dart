import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mbookmark.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/screens/rideBookDetail.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/twoColumnView.dart';
import 'package:intl/intl.dart';

import '../resources/rideScheduleApi.dart';

class RideBookmark extends StatefulWidget {
  const RideBookmark({super.key});

  @override
  State<RideBookmark> createState() => _RideBookmarkState();
}

class _RideBookmarkState extends State<RideBookmark> {
  List<Bookmark> bookmarkedList = [];
  bool? bookmarkedListLoading;

  void initState() {
    super.initState();
    initRideSchedule();
  }

  initRideSchedule() async {
    setState(() {
      bookmarkedListLoading = true;
    });

    bookmarkedList = await rideScheduleApi.getBookmarkList(userId: config.user.id!);
    setState(() {
      bookmarkedListLoading = false;
    });
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/lingkaranKuning_2.png",
              width: MediaQuery.of(context).size.width * 0.815,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.085,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: NunutText(title: "Bookmark", size: 32, isTitle: true),
                ),
              ],
            ),
          ),
          bookmarkedListLoading!
              ? Center(
                  child: CircularProgressIndicator(
                    color: nunutPrimaryColor,
                  ),
                )
              : bookmarkedList.isNotEmpty
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.22,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            initRideSchedule();
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: bookmarkedList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RideBookDetail(
                                        rideScheduleId: bookmarkedList[index].rideSchedule.id!,
                                      ),
                                    ),
                                  ).then((value) => onGoBack(value));
                                },
                                child: TwoColumnView(
                                  imagePath: bookmarkedList[index].driver.image,
                                  departureTime: bookmarkedList[index].rideSchedule.time!,
                                  name: bookmarkedList[index].driver.name,
                                  destination: bookmarkedList[index].rideSchedule.destination!.name!,
                                  price: priceFormat(bookmarkedList[index].rideSchedule.price!.toString()),
                                  isBookmarked: true,
                                  capacity: bookmarkedList[index].rideSchedule.capacity!,
                                  totalBooked: bookmarkedList[index].rideSchedule.rideRequest!.length,
                                  IconOnTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: NunutText(title: 'Hapus bookmark ini ?', size: 20, fontWeight: FontWeight.bold),
                                        content: NunutText(title: "Anda dapat melakukan bookmark pada tumpangan ini lagi nanti jika tumpangan masih tersedia."),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: NunutText(title: "Cancel", color: Colors.red),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              rideScheduleApi.deleteBookmarkByBookmarkId(bookmarkId: bookmarkedList[index].id);
                                              Fluttertoast.showToast(msg: "Bookmark berhasil dihapus");
                                              setState(() {
                                                bookmarkedList.removeAt(index);
                                              });
                                            },
                                            child: NunutText(title: "OK", color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text("No bookmarked ride"),
                    ),
        ],
      ),
    );
  }

  onRefresh() async {
    bookmarkedListLoading = true;
    await initRideSchedule();
  }
}
