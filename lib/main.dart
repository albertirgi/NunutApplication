import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/screens/addRideSchedule.dart';
import 'package:nunut_application/screens/batalkanTumpangan.dart';
import 'package:nunut_application/screens/bookingDetail.dart';
import 'package:nunut_application/screens/bookingParkir.dart';
import 'package:nunut_application/screens/chatInside.dart';
import 'package:nunut_application/screens/chatPage.dart';
import 'package:nunut_application/screens/detailNotification.dart';
import 'package:nunut_application/screens/detailProfilePage.dart';
import 'package:nunut_application/screens/distance.dart';
import 'package:nunut_application/screens/driverRegistration.dart';
import 'package:nunut_application/screens/home.dart';
import 'package:nunut_application/screens/login.dart';
import 'package:nunut_application/screens/mainScreen.dart';
import 'package:nunut_application/screens/success.dart';
import 'package:nunut_application/screens/nunutPay.dart';
import 'package:nunut_application/screens/offerMenu.dart';
import 'package:nunut_application/screens/orderList.dart';
import 'package:nunut_application/screens/parkingList.dart';
import 'package:nunut_application/screens/parkingSlotDetail.dart';
import 'package:nunut_application/screens/pengaduanKendala.dart';
import 'package:nunut_application/screens/promotionDetail.dart';
import 'package:nunut_application/screens/promotionList.dart';
import 'package:nunut_application/screens/qrCode.dart';
import 'package:nunut_application/screens/register.dart';
import 'package:nunut_application/screens/rideBookmark.dart';
import 'package:nunut_application/screens/splashscreen.dart';
import 'package:nunut_application/screens/rideList.dart';
import 'package:nunut_application/screens/termsCons.dart';
import 'package:nunut_application/screens/topUp.dart';
import 'package:nunut_application/screens/topUpPayment.dart';
import 'package:nunut_application/screens/tripHistory.dart';
import 'package:nunut_application/screens/myVehicle.dart';
import 'package:nunut_application/screens/withdraw.dart';
import 'package:nunut_application/screens/withdrawConfirmation.dart';
import 'package:nunut_application/screens/addVehicle.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nunut_application/screens/lupaPassword.dart';
import 'package:nunut_application/screens/otp.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/bookingDetail': (context) => BookingDetail(
              rideSchedule: RideSchedule(
                date: "",
                time: "",
                id: "",
                price: 10000,
                meetingPoint: MapLocation(latitude: "", longitude: ""),
                destination: MapLocation(latitude: "", longitude: ""),
                driver: "",
              ),
            ),
        '/promotionList': (context) => const PromotionList(),
        '/promotionDetail': (context) => const PromotionDetail(),
        '/orderList': (context) => const OrderList(),
        '/register': (context) => const RegisterPage(),
        '/chat': (context) => const ChatPage(),
        '/chatInside': (context) => const ChatInsidePage(),
        '/bookingParkir': (context) => const BookingParkir(),
        '/parkingList': (context) => const ParkingList(),
        '/parkingSlotDetail': (context) => const parkingSpotDetail(),
        '/rideList': (context) => const RideList(),
        '/tripHistory': (context) => const TripHistory(),
        '/qrCode': (context) => QRCode(),
        '/rideBookmark': (context) => const RideBookmark(),
        '/offerMenu': (context) => const OfferMenu(),
        '/myVehicle': (context) => const MyVehicle(),
        '/addVehicle': (context) => const AddVehicle(),
        '/addRideSchedule': (context) => const AddRideSchedule(),
        '/detailprofile': (context) => const DetailProfilePage(),
        '/driverRegistration': (context) => const DriverRegistration(),
        '/detailNotification': (context) => const DetailNotificationPage(),
        '/pengaduanKendala': (context) => const PengaduanKendalaPage(),
        '/batalkanTumpangan': (context) => const BatalkanTumpangan(),
        '/success': (context) => Success(),
        '/home': (context) => const Home(),
        '/nunutPay': (context) => const NunutPay(),
        '/topUp': (context) => const TopUp(),
        '/withdraw': (context) => const Withdraw(),
        '/withdrawConfirmation': (context) => const WithdrawConfirmation(),
        '/distance': (context) => const Distance(),
        '/topUpPayment': (context) => TopUpPayment(
              data: {
                'id': '1',
                'name': 'Top Up',
                'price': '100000',
                'image': 'assets/images/topup.png',
              },
            ),
        '/termsandcons': (context) => TermAndConsPage(),
        '/lupaPassword': (context) => LupaPasswordPage(),
        '/otp' : (context) => OTPPage(),
      },
    );
  }
}
