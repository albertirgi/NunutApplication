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
    SharedPreferences prefs = await SharedPreferences.getInstance().then((value) {
      // var email = value.getString('email');
      // var token = value.getString("token");
      // var id = value.getString("id");
      // if (token != "" && email != "") {
      //   print(email);
      //   print(" MAMBU BANGET ");
      //   print(token);
      //   print(id);
      // }
      return value;
    });

    if (prefs.getString("token") != null) {
      haveToken = true;
      config.user = await UserService().getUserByID(prefs.getString("id")!);
      config.user.token = prefs.getString("token");
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
