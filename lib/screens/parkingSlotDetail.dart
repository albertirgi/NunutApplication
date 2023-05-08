import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/models/mparkingbuilding.dart';
import 'package:nunut_application/resources/bookingParkirApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

class parkingSpotDetail extends StatefulWidget {
  const parkingSpotDetail({super.key});

  @override
  State<parkingSpotDetail> createState() => _parkingSpotDetailState();
}

class _parkingSpotDetailState extends State<parkingSpotDetail> {
  String image = '';
  String title = '';
  String subTitle = '';
  List<String> instruction = [];
  String parking_slot_id = '';
  String id_ride = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final data = arg['data'] as ParkingSlot;
    final idRide = arg['idRide'] as String;
    image = data.image;
    title = data.title;
    subTitle = data.subtitle;
    instruction = data.instruction;
    parking_slot_id = data.parkingSlotId;
    id_ride = idRide;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Petunjuk",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: instruction.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${index + 1}." + instruction[index],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: nunutPrimaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: NunutButton(
                      title: "Pesan",
                      onPressed: () async {
                        var status_post = await BookingParkirApi.SendBookingParkir(parking_slot_id, id_ride);
                        var status_update_slot = await BookingParkirApi.UpdateStatusSlotParkir(parking_slot_id);
                        log("status post " + status_post.toString());
                        log("status update slot " + status_update_slot.toString());
                        if (status_post == true && status_update_slot == true) {
                          Fluttertoast.showToast(msg: "Booking Parkir Sukses");
                          Navigator.popUntil(context, ModalRoute.withName('/rideList'));
                        } else {
                          Fluttertoast.showToast(msg: "Booking Parkir Gagal");
                        }
                      },
                      widthBorder: 0,
                      widthButton: 146,
                      heightButton: 44,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
