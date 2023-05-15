import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool goToMain = false;
  @override
  void initState() {
    checkToken();
    Timer(Duration(seconds: 3), () {
      goToMain ? Navigator.pushReplacementNamed(context, '/main') : Navigator.pushReplacementNamed(context, '/login');
    });
    super.initState();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      var url = Uri.parse(config.baseUrl + '/check-token/${prefs.getString("token")}');
      http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token")}',
        },
      ).then((value) {
        Result result;
        result = Result.fromJson(json.decode(value.body));
        print(jsonEncode(json.decode(value.body)));
        if (result.data) {
          goToMain = true;
          String token = prefs.getString("token")!;
          config.user.token = token;
          UserService().getUserByID(prefs.getString("id")!).then((value) => config.user = value);
        } else {
          goToMain = false;
          SharedPreferences.getInstance().then((prefs) {
            prefs.clear();
          });
        }
      });
    } else {
      goToMain = false;
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
