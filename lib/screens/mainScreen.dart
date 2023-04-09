import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/resources/driverApi.dart';
import 'package:nunut_application/screens/home.dart';
import 'package:nunut_application/screens/offerMenu.dart';
import 'package:nunut_application/screens/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currentBackPressTime;
  @override
  void initState() {
    // TODO: implement initState
    config.selectedNavbar = 1;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<bool> _onWillPop() async {
    // return (await showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: NunutText(title: 'Keluar dari aplikasi', color: Colors.black, size: 18, fontWeight: FontWeight.bold),
    //         content: NunutText(title: 'Apakah anda yakin ingin keluar dari aplikasi?', color: Colors.black, size: 16),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(false),
    //             child: NunutText(title: 'Tidak', color: Colors.black, size: 16),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(true),
    //             child: NunutText(title: 'Ya', color: Colors.black, size: 16),
    //           ),
    //         ],
    //       ),
    //     )) ??
    //     false;

    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tekan sekali lagi untuk keluar dari aplikasi",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      switch (config.selectedNavbar) {
        case 0:
          if (config.user.driverId == "empty") {
            config.selectedNavbar = 1;
            Fluttertoast.showToast(
              msg: "Mohon mendaftar sebagai driver sebelum mengakses halaman ini",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pushNamed('/driverRegistration', arguments: config.user);
            });
            return const Home();
          } else {
            if (config.user.driverStatus?.toLowerCase() == "pending") {
              config.selectedNavbar = 1;
              Fluttertoast.showToast(
                msg: "Data sedang diproses oleh admin. mohon menunggu",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              return const Home();
            } else if (config.user.driverStatus?.toLowerCase() == "rejected") {
              config.selectedNavbar = 1;
              Fluttertoast.showToast(
                msg: "Mohon maaf, permintaan anda ditolak, harap mengajukan permintaan kembali",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              return const Home();
            } else if (config.user.driverStatus?.toLowerCase() == "approved") {
              setState(() {
                config.selectedNavbar = 0;
              });
              return const OfferMenu();
            }
          }
          return const Home();
        case 1:
          return const Home();
        case 2:
          return const ProfilePage();
        default:
          return const Home();
      }
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            buildContent(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
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
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Icon(Icons.car_crash, size: 30),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Icon(Icons.route, size: 30),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Icon(Icons.person, size: 30),
                ),
                label: "",
              ),
            ],
            currentIndex: config.selectedNavbar,
            selectedItemColor: Colors.yellowAccent,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                config.selectedNavbar = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
