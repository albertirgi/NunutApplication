import 'package:flutter/material.dart';
import 'package:nunut_application/screens/home.dart';
import 'package:nunut_application/screens/profile.dart';
import 'package:nunut_application/screens/transaction.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      print("Selected index : {$_selectedNavbar}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const TransactionPage();
        case 2:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      body: Stack(
        children: [buildContent(_selectedNavbar)],
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
