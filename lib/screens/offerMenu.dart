import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfferMenu extends StatefulWidget {
  const OfferMenu({super.key});

  @override
  State<OfferMenu> createState() => _OfferMenuState();
}

class _OfferMenuState extends State<OfferMenu> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _meetingPointController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  int _capacityValue = 1;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _meetingPointController.dispose();
    _destinationController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: nunutPrimaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 90, left: 28, right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(
                  title: "Hai, ${config.user.name}",
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                NunutText(
                    title: "Yuk tawarkan tumpangan!", isTitle: true, size: 32),
                // BorderedText(
                //   child: Text(
                //     "Yuk tawarkan tumpangan!",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 32,
                //     ),
                //   ),
                //   strokeWidth: 3.0,
                //   strokeColor: Colors.black,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   width: 190,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(
                //       color: Colors.black,
                //       width: 2,
                //     ),
                //     borderRadius: BorderRadius.circular(50),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Icon(Icons.money_outlined),
                //       NunutText(
                //         title: "IDR 50.000",
                //         fontWeight: FontWeight.bold,
                //         size: 18,
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 50,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/addRideSchedule', arguments: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NunutText(
                              title: "Tawarkan",
                              fontWeight: FontWeight.bold,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/rideList');
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: nunutPrimaryColor,
                              ),
                              child: Icon(
                                Icons.people_sharp,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NunutText(
                              title: "Tumpanganku",
                              fontWeight: FontWeight.bold,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.all(40),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color: nunutPrimaryColor,
                      //       ),
                      //       child: Icon(
                      //         Icons.chat_bubble,
                      //         size: 50,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 10,
                      //     ),
                      //     NunutText(
                      //       title: "Chat",
                      //       fontWeight: FontWeight.bold,
                      //       size: 18,
                      //     ),
                      //   ],
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/myVehicle");
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: nunutPrimaryColor,
                              ),
                              child: Icon(FontAwesomeIcons.car, size: 30),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NunutText(
                              title: "Kendaraanku",
                              fontWeight: FontWeight.bold,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
