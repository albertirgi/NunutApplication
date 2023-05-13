import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool sendEmailVerification = false;

  late UserModel tmpUser = UserModel(email: "", name: "", nik: "", phone: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

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
                    FocusManager.instance.primaryFocus?.unfocus();
                    final connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      Fluttertoast.showToast(msg: "Mohon cek kembali koneksi internet anda", textColor: Colors.white);
                    } else {
                      if (username.text == "" || password.text == "") {
                        Fluttertoast.showToast(msg: "Email dan password harus diisi", textColor: Colors.white);
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return PopUpLoading(title: "Sedang Login...", subtitle: "Harap Menunggu...");
                          },
                        );

                        String token = await AuthService.getToken(username.text, password.text);
                        config.user.token = token;

                        await AuthService.signIn(email: username.text, password: password.text).then((value) => {
                              Navigator.pop(context),
                              tmpUser = value,
                            });
                        if (tmpUser.email != "") {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          if (!auth.currentUser!.emailVerified) {
                            Fluttertoast.showToast(
                              msg: "Mohon cek email anda untuk verifikasi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            sendEmailVerification = true;
                            setState(() {});
                          } else {
                            config.user = tmpUser;
                            config.user.token = token;
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("email", config.user.email);
                            prefs.setString("token", config.user.token!);
                            prefs.setString("id", config.user.id!);
                            Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                          }
                        }
                      }
                    }
                  },
                ),
                SizedBox(height: 24),
                NunutText(
                  title: "Belum punya akun?",
                  size: 14,
                  color: greyFontColor,
                ),
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
                ),
                SizedBox(height: 24),
                sendEmailVerification
                    ? InkWell(
                        child: NunutText(
                          title: "Kirim ulang email verifikasi",
                          size: 13,
                          color: greyFontColor,
                          textDecoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return PopUpLoading(title: "Loading", subtitle: "Harap Menunggu...");
                            },
                          );
                          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: "Email verifikasi berhasil dikirim",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          sendEmailVerification = false;
                          setState(() {});
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
