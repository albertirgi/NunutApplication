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
                      Fluttertoast.showToast(msg: "Cek Kembali Email dan Password Anda");
                    } else {
                      tmpUser = await AuthService.signIn(email: username.text, password: password.text);
                      if (tmpUser.email != "") {
                        config.user = tmpUser;
                        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                      } else {
                        Fluttertoast.showToast(msg: "Cek Kembali Email dan Password Anda");
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                    ),
                    const NunutText(title: "Atau"),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                NunutButton(
                  title: "Masuk GOOGLE",
                  widthButton: 200,
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                const SizedBox(height: 24),
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
}
