import 'package:flutter/material.dart';
import 'package:nunut_application/models/muser.dart';

class Configuration extends InheritedWidget {
  static Configuration of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Configuration>()!;
  }

  String baseUrl = 'https://ayonunut.com/api/v1';
  String googleAPiKey = "AIzaSyCkoZat0Qep754cgH-hWly8mrDi_gniw-o";

  Configuration({Key? key, Widget? child}) : super(key: key, child: child != null ? child : MaterialApp());
  bool updateShouldNotify(Configuration oldWidget) => true;

  UserModel user = UserModel(email: "", name: "", nik: "", phone: "", token: "");
  String token = "";
  int selectedNavbar = 1;
  String? selectedBuilding;
  String mapIdPetra = "074d950a-44ab-408a-9c00-03f4f9da42c3";
}

Configuration config = Configuration();
