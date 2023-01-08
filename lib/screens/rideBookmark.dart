import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/widgets/twoColumnView.dart';
import 'package:intl/intl.dart';

import '../resources/rideScheduleApi.dart';

class RideBookmark extends StatefulWidget {
  const RideBookmark({super.key});

  @override
  State<RideBookmark> createState() => _RideBookmarkState();
}

class _RideBookmarkState extends State<RideBookmark> {
  List<RideSchedule> rideScheduleList = [];
  List<RideSchedule> bookmarkedList = [];
  bool? rideScheduleListLoading;

  void initState() {
    super.initState();
    initRideScheduleList();
  }

  initRideScheduleList() async {
    setState(() {
      rideScheduleListLoading = true;
    });

    rideScheduleList.clear();
    rideScheduleList = await rideScheduleApi.getRideScheduleList(parameter: "${config.user.id}&driver");

    //filter bookmark
    bookmarkedList.clear();
    rideScheduleList.forEach((element) {
      if (element.isBookmarked == true) {
        bookmarkedList.add(element);
      }
    });

    setState(() {
      rideScheduleListLoading = false;
    });
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
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: BorderedText(
                    child: Text(
                      "Bookmark",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    strokeWidth: 4.5,
                    strokeColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          bookmarkedList.isNotEmpty
              ? Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: rideScheduleList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        return TwoColumnView(
                          imagePath: "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                          departureTime: bookmarkedList[index].time!,
                          name: bookmarkedList[index].userId!,
                          destination: "SPBU Manyar",
                          price: NumberFormat.currency(
                            locale: 'id',
                            symbol: '',
                            decimalDigits: 0,
                          ).format(bookmarkedList[index].price!),
                        );
                      },
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
}
