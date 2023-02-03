import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/profileParking.dart';
import 'package:nunut_application/resources/parkingPlaceApi.dart';
import '../models/mparkingplace.dart';
import '../theme.dart';

class BookingParkir extends StatefulWidget {
  const BookingParkir({super.key});

  @override
  State<BookingParkir> createState() => _BookingParkirState();
}

class _BookingParkirState extends State<BookingParkir> {
  List<ParkingPlaceModel> ParkingPlaceList = [];
  @override
  void initState() {
    super.initState();
    initParkingPlace();
  }

  initParkingPlace() async {
    ParkingPlaceList.clear();
    ParkingPlaceList = await parkingPlaceApi.getParkingPlace();
    setState(() {
      ParkingPlaceList = ParkingPlaceList;
      //log("isi notif list : " + jsonEncode(NotificationList));
    });
    //log("isi length " + NotificationList.length.toString());
    //log("isi NotificationList " + NotificationList.toString());
    //log("isi NotificationList " + NotificationList[0].title.toString());
    // for(int i = 0; i < NotificationList.length; i++){
    //   log("isi NotificationList " + NotificationList[i].title.toString());
    // }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedText(
                child: Text(
                  "Booking Parkir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                strokeWidth: 3.0,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 20),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, '/parkingList',
                              arguments: ParkingPlaceList[index]),
                          child: profileParkingCard(
                            image: ParkingPlaceList[index].image,
                            title: ParkingPlaceList[index].name,
                            subtitle: ParkingPlaceList[index].subName,
                            count: "5",
                            maxCapacity: "16",
                          ),
                        );
                      },
                      itemCount: ParkingPlaceList.length,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 100,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: nunutPrimaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
