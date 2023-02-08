import 'package:flutter/material.dart';
import 'package:nunut_application/models/muser.dart';

class Configuration extends InheritedWidget {
  static Configuration of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Configuration>()!;
  }

  String baseUrl = 'https://ayonunut.com/api/v1';
  String googleAPiKey = "AIzaSyCkoZat0Qep754cgH-hWly8mrDi_gniw-o";
  //String baseUrl = "http://104.208.76.39/api/v1";

  Configuration({Key? key, Widget? child}) : super(key: key, child: child != null ? child : MaterialApp());
  bool updateShouldNotify(Configuration oldWidget) => true;

  late UserModel user;
  int selectedNavbar = 1;
}

Configuration config = Configuration();
