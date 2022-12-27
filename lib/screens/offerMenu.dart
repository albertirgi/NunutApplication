import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/couponCard.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutCard.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';

class OfferMenu extends StatefulWidget {
  const OfferMenu({super.key});

  @override
  State<OfferMenu> createState() => _OfferMenuState();
}

class _OfferMenuState extends State<OfferMenu> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      print("Selected index : {$_selectedNavbar}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget buildContent(int currentIndex) {
    //   switch (currentIndex) {
    //     case 0:
    //       return const HomePage();
    //     case 1:
    //       return const TransactionPage();
    //     case 2:
    //       return const ProfilePage();
    //     default:
    //       return const HomePage();
    //   }
    // }

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
            margin: EdgeInsets.only(top: 52, left: 28, right: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(
                  title: "Hai, Grace",
                  fontWeight: FontWeight.bold,
                ),
                BorderedText(
                  child: Text(
                    "Yuk tawarkan tumpangan!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  strokeWidth: 3.0,
                  strokeColor: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.money_outlined),
                      NunutText(
                        title: "IDR 50.000",
                        fontWeight: FontWeight.bold,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 50,
                    children: [
                      Column(
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
                      Column(
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
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: nunutPrimaryColor,
                            ),
                            child: Icon(
                              Icons.chat_bubble,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NunutText(
                            title: "Chat",
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: nunutPrimaryColor,
                            ),
                            child: Icon(
                              Icons.car_crash,
                              size: 50,
                              color: Colors.black,
                            ),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.car_crash),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.route),
                label: "Transaction",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedNavbar,
            selectedItemColor: Colors.yellowAccent,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: _changeSelectedNavBar,
          ),
        ),
      ),
    );
  }
}
