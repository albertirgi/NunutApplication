import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mbookmark.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mrideschedule.dart';
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
  // List<RideSchedule> rideScheduleList = [];
  bool? bookmarkedListLoading;

  void initState() {
    super.initState();
    initRideScheduleList();
  }

  initRideScheduleList() async {
    setState(() {
      bookmarkedListLoading = true;
    });

    bookmarkedList = await rideScheduleApi.getBookmarkList(userId: config.user.id!, checkUrl: true);

    setState(() {
      bookmarkedListLoading = false;
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
          bookmarkedListLoading!
              ? Center(child: CircularProgressIndicator())
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
                            initRideScheduleList();
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: bookmarkedList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                            itemBuilder: (context, index) {
                              return TwoColumnView(
                                imagePath: bookmarkedList[index].driver.image,
                                departureTime: bookmarkedList[index].rideSchedule.time!,
                                name: bookmarkedList[index].driver.name,
                                destination: bookmarkedList[index].rideSchedule.destination!.name!,
                                price: NumberFormat.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ).format(bookmarkedList[index].rideSchedule.price!),
                                isBookmarked: true,
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
                                            rideScheduleApi.deleteBookmarkByBookmarkId(bookmarkId: bookmarkedList[index].id, checkUrl: true);
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
}
