import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:nunut_application/widgets/popUpLoading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var haveToken = false;
  bool tokenLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //checkToken
  // void checkToken() async {
  //   setState(() {
  //     tokenLoading = true;
  //   });

  //   SharedPreferences prefs = await SharedPreferences.getInstance().then((value) {
  //     var email = value.getString('email');
  //     var token = value.getString("token");
  //     var id = value.getString("id");
  //     if (token != "" && email != "") {
  //       print(email);
  //       print(" MAMBU BANGET ");
  //       print(token);
  //     }
  //     return value;
  //   });

  //   if (prefs.getString("token") != null) {
  //     haveToken = true;
  //     config.user = await UserService().getUserByID(prefs.getString("id")!);
  //     Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  //   } else {
  //     haveToken = false;
  //   }

  //   setState(() {
  //     tokenLoading = false;
  //   });
  // }

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
                  title: "Email Pengguna",
                  hintText: "Email Pengguna",
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
                SizedBox(height: 24),
                NunutButton(
                  title: "Masuk",
                  widthButton: 200,
                  onPressed: () async {
                    if (username.text == "" || password.text == "") {
                      Fluttertoast.showToast(
                          msg: "Email dan password harus diisi",
                          textColor: Colors.white);
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return PopUpLoading(
                              title: "Sedang Login...",
                              subtitle: "Harap Menunggu...");
                        },
                      );

                      tmpUser.token = await AuthService.getToken(
                          username.text, password.text);
                      config.user.token = tmpUser.token;
                      tmpUser = await AuthService.signIn(
                          email: username.text,
                          password: password.text,
                          context: context);

                      if (tmpUser.email != "") {
                        config.user = tmpUser;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("email", tmpUser.email);
                        prefs.setString("token", tmpUser.token!);
                        prefs.setString("id", tmpUser.id!);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/main', (route) => false);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Email atau password salah",
                            textColor: Colors.white);
                      }
                    }
                  },
                ),
                // SizedBox(height: 24),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Container(
                //         margin: EdgeInsets.only(right: 10),
                //         height: 1.5,
                //         width: MediaQuery.of(context).size.width,
                //         color: Colors.black,
                //       ),
                //     ),
                //     NunutText(title: "Atau"),
                //     Expanded(
                //       flex: 1,
                //       child: Container(
                //         margin: EdgeInsets.only(left: 10),
                //         height: 1.5,
                //         width: MediaQuery.of(context).size.width,
                //         color: Colors.black,
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 16),
                // NunutButton(
                //   title: "Masuk GOOGLE",
                //   widthButton: 200,
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/register');
                //   },
                // ),
                SizedBox(height: 24),
                NunutText(
                  title: "Belum punya akun?",
                  size: 14,
                  color: greyFontColor,
                ),
                //SizedBox(height: 8),
                InkWell(
                  child: NunutText(
                    title: "Daftar Sekarang",
                    size: 14,
                    color: greyFontColor,
                    textDecoration: TextDecoration.underline,
                    fontWeight: FontWeight.w800,
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

//   Widget PopUpLoginLoading() {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         height: 200,
//         width: 120,
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
//                 padding: EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(38),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: CircularProgressIndicator(
//                   value: null,
//                   strokeWidth: 3.0,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 20.0),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     NunutText(title: "Sedang Login...", size: 20, fontWeight: FontWeight.bold),
//                     NunutText(title: "Harap Menunggu...", size: 14, fontWeight: FontWeight.w500),
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
}
