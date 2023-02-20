import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';

import '../models/muser.dart';
import '../resources/authApi.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false;

  late UserModel tmpUser = UserModel(email: "", name: "", nik: "", phone: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nunutPrimaryColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 24, left: 24),
          padding: const EdgeInsets.all(16),
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
                NunutTextFormField(
                  title: "Nama Pengguna",
                  hintText: "Nama Pengguna",
                  obsecureText: false,
                  controller: username,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "Kata Sandi",
                  hintText: "Kata Sandi",
                  obsecureText: !passwordVisible,
                  controller: password,
                  width: 1.5,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                NunutButton(
                  title: "Masuk",
                  widthButton: 200,
                  onPressed: () async {
                    if (username.text == "" || password.text == "") {
                      Fluttertoast.showToast(msg: "Email dan password harus diisi", textColor: Colors.white);
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return PopUpLoginLoading();
                        },
                      );
                      tmpUser = await AuthService.signIn(email: username.text, password: password.text, context: context);

                      if (tmpUser.email != "") {
                        config.user = tmpUser;
                        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                      } else {
                        Fluttertoast.showToast(msg: "Email atau password salah", textColor: Colors.white);
                      }
                    }
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                    ),
                    NunutText(title: "Atau"),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                NunutButton(
                  title: "Masuk GOOGLE",
                  widthButton: 200,
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                SizedBox(height: 24),
                InkWell(
                  child: NunutText(
                    title: "Belum punya akun? daftar sekarang",
                    size: 12,
                    color: nunutPrimaryColor,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PopUpLoginLoading() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: 200,
        width: 120,
        decoration: BoxDecoration(
          color: nunutPrimaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 3.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NunutText(title: "Sedang Login...", size: 20, fontWeight: FontWeight.bold),
                    NunutText(title: "Harap Menunggu...", size: 14, fontWeight: FontWeight.w500),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class PopUpLoginLoading extends StatelessWidget {
//   const PopUpLoginLoading({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         height: 150,
//         width: 100,
//         decoration: BoxDecoration(
//           color: nunutPrimaryColor,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Container(
//                 margin: EdgeInsets.only(top: 25.0),
//                 child: CircularProgressIndicator(
//                   value: null,
//                   strokeWidth: 5.0,
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 25.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     NunutText(title: "Login...", color: Colors.white, size: 20, fontWeight: FontWeight.w500),
//                     NunutText(title: "Mohon Tunggu", color: Colors.white, size: 20, fontWeight: FontWeight.w500),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
