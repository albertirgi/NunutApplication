import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool haveToken = false;
  @override
  void initState() {
    checkToken();
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      haveToken ? Navigator.pushReplacementNamed(context, '/main') : Navigator.pushReplacementNamed(context, '/login');
    });
    super.initState();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      haveToken = true;
      config.user.token = await prefs.getString("token");
      config.user = await UserService().getUserByID(prefs.getString("id")!);
    } else {
      haveToken = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/splashscreen.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
