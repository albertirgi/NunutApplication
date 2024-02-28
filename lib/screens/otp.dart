import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import '../widgets/nunutText.dart';
import 'package:pinput/pinput.dart';

import '../models/muser.dart';
import '../resources/authApi.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false;
  bool sendEmailVerification = false;

  late UserModel tmpUser = UserModel(email: "", name: "", nik: "", phone: "");

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: nunutLightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      backgroundColor: nunutPrimaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 24, left: 24),
          padding: const EdgeInsets.all(16),
          height: 700,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  child: Image.asset(
                    "assets/icon.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: NunutText(title: "OTP Verification", isTitle: true, size: 32),
                ),
                InkWell(
                  child: NunutText(
                    title: "Kode telah dikirim ke nomor",
                    size: 15,
                    color: greyFontColor,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  child: NunutText(
                    title: "+62 812 3456 7890",
                    size: 15,
                    color: greyFontColor,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24),
                Pinput(
                  length: 5,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: nunutPrimaryColor, width: 2),
                    ),
                  ),
                  onCompleted: (pin) => debugPrint(pin),
                ),
                SizedBox(width: 340,)
              ]
            )
          )
        )
      )
    );
  
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.all(20),
  //       child: Container(
  //         margin: const EdgeInsets.only(top: 40),
  //         width: double.infinity,
  //         child: Column(
  //           children: [
  //             const Text(
  //               "Verification",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 28,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.symmetric(vertical: 40),
  //               child: const Text(
  //                 "Enter the code sent to your number",
  //                 style: TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.only(bottom: 40),
  //               child: const Text(
  //                 "+93 744 795 640",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //             ),
  //             Pinput(
  //               length: 5,
  //               defaultPinTheme: defaultPinTheme,
  //               focusedPinTheme: defaultPinTheme.copyWith(
  //                 decoration: defaultPinTheme.decoration!.copyWith(
  //                   border: Border.all(color: Colors.green),
  //                 ),
  //               ),
  //               onCompleted: (pin) => debugPrint(pin),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  }
}
