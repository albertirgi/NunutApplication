import 'package:flutter/material.dart';
import 'package:nunut_application/screens/bookingDetail.dart';
import 'package:nunut_application/screens/chatPage.dart';
import 'package:nunut_application/screens/login.dart';
import 'package:nunut_application/screens/mainScreen.dart';
import 'package:nunut_application/screens/orderList.dart';
import 'package:nunut_application/screens/promotionDetail.dart';
import 'package:nunut_application/screens/promotionList.dart';
import 'package:nunut_application/screens/register.dart';
import 'package:nunut_application/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/bookingDetail': (context) => const BookingDetail(),
        '/promotionList': (context) => const PromotionList(),
        '/promotionDetail': (context) => const PromotionDetail(),
        '/orderList': (context) => const OrderList(),
        '/register': (context) => const RegisterPage(),
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}
