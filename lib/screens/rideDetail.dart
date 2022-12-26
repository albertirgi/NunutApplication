import 'dart:ffi';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';
import 'package:flutter_dash/flutter_dash.dart';

class RideDetail extends StatefulWidget {
  const RideDetail({super.key});

  @override
  State<RideDetail> createState() => _RideDetailState();
}

class _RideDetailState extends State<RideDetail> {
  TextEditingController searchController = TextEditingController();
  bool isActiveClicked = false;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12, left: 28, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  NunutText(
                    title: "Tumpangan NUNUT #XYD139",
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10),
                  NunutText(
                    title: "Senin, 24 Oktober 2022",
                    fontWeight: FontWeight.bold,
                    size: 22,
                  ),
                  NunutText(
                    title: "08.00 WIB",
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
                                  child: NunutText(
                                    title: "Galaxy Mall 3",
                                    size: 16,
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
                                    color: nunutPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: NunutText(
                                    title: "Universitas Kristen Petra",
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        NunutButton(
                          title: "Peta",
                          widthButton: 90,
                          heightButton: 35,
                          textSize: 14,
                          borderColor: Colors.transparent,
                          iconButton: Icon(
                            Icons.map_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NunutText(
                        title: "Daftar Penumpang",
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
                            ),
                          ),
                          SizedBox(width: 10),
                          NunutText(
                            title: "Rachel Tanuwidjaja",
                            fontWeight: FontWeight.w500,
                            size: 14,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  index % 2 == 1
                                      ? Icons.check_circle_outline
                                      : Icons.cancel_outlined,
                                  size: 35,
                                  color: index % 2 == 1
                                      ? Colors.green
                                      : Colors.red,
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
                    itemCount: 3,
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  SizedBox(height: 10),
                  NunutText(
                    title: "Tempat Parkir",
                    fontWeight: FontWeight.bold,
                    size: 16,
                  ),
                  SizedBox(height: 5),
                  NunutText(
                    title: "Yuk pesan tempat parkir sekarang!",
                    fontWeight: FontWeight.w500,
                    size: 14,
                  ),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
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
    );
  }
}
