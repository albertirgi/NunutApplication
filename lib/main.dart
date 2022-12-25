import 'package:flutter/material.dart';
import 'package:nunut_application/screens/bookingDetail.dart';
import 'package:nunut_application/screens/bookingParkir.dart';
import 'package:nunut_application/screens/chatInside.dart';
import 'package:nunut_application/screens/chatPage.dart';
import 'package:nunut_application/screens/login.dart';
import 'package:nunut_application/screens/mainScreen.dart';
import 'package:nunut_application/screens/orderList.dart';
import 'package:nunut_application/screens/parkingList.dart';
import 'package:nunut_application/screens/parkingSlotDetail.dart';
import 'package:nunut_application/screens/payment.dart';
import 'package:nunut_application/screens/promotionDetail.dart';
import 'package:nunut_application/screens/promotionList.dart';
import 'package:nunut_application/screens/qrCode.dart';
import 'package:nunut_application/screens/register.dart';
import 'package:nunut_application/screens/rideBookDetail.dart';
import 'package:nunut_application/screens/rideBookmark.dart';
import 'package:nunut_application/screens/splashscreen.dart';
import 'package:nunut_application/screens/rideList.dart';
import 'package:nunut_application/screens/tripHistory.dart';

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
        '/chatInside': (context) => const ChatInsidePage(),
        '/payment': (context) => const Payment(),
        '/bookingParkir': (context) => const BookingParkir(),
        '/parkingList': (context) => const ParkingList(),
        '/parkingSlotDetail': (context) => const parkingSpotDetail(),
        '/rideList': (context) => const RideList(),
        '/tripHistory': (context) => const TripHistory(),
        '/qrCode': (context) => const QRCode(),
        '/rideBookDetail': (context) => const RideBookDetail(),
        '/rideBookmark': (context) => const RideBookmark(),
      },
    );
  }
}
