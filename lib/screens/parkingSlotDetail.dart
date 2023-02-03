import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nunut_application/models/mparkingbuilding.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final data = ModalRoute.of(context)!.settings.arguments as ParkingSlot;
    log("isi data " + jsonEncode(data).toString());
    image = data.image;
    title = data.title;
    subTitle = data.subtitle;
    instruction = data.instruction;
  }

  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)!.settings.arguments as ParkingSlotModel;
    // log("isi data " + jsonEncode(data).toString());
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
                          //icon bullet

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
                      onPressed: () {},
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
