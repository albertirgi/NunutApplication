import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/screens/home.dart';
import 'package:nunut_application/screens/offerMenu.dart';
import 'package:nunut_application/screens/profile.dart';
import 'package:nunut_application/screens/transaction.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    config.selectedNavbar = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      switch (config.selectedNavbar) {
        case 0:
          return const OfferMenu();
        case 1:
          return const Home();
        case 2:
          return const ProfilePage();
        default:
          return const Home();
      }
    }

    return Scaffold(
      body: Stack(
        children: [buildContent()],
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
