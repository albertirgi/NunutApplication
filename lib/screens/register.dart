import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/screens/tnc.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/authApi.dart';
import '../widgets/nunutText.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  bool passwordVisible = false;
  bool confirmationPasswordVisible = false;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
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
                NunutTextFormField(
                  title: "Email",
                  hintText: "Example@email.com",
                  obsecureText: false,
                  controller: email,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "Nama Lengkap",
                  hintText: "Nama Lengkap",
                  obsecureText: false,
                  controller: fullName,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "Kata Sandi",
                  hintText: "Kata Sandi ",
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
                NunutTextFormField(
                  title: "Konfirmasi Kata Sandi",
                  hintText: "Konfirmasi Kata Sandi ",
                  obsecureText: !confirmationPasswordVisible,
                  controller: confirmPassword,
                  width: 1.5,
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmationPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmationPasswordVisible = !confirmationPasswordVisible;
                      });
                    },
                  ),
                ),
                NunutTextFormField(
                  title: "NIK",
                  hintText: "NIK ",
                  obsecureText: false,
                  controller: nik,
                  width: 1.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Nomor Telepon",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            color: nunutPrimaryColor,
                          ),
                          child: Center(
                            child: NunutText(
                              title: "+62",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            obscureText: false,
                            controller: noTelp,
                            decoration: InputDecoration(
                              hintText: "Nomor Telepon",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Material(
                      child: Checkbox(
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value ?? false;
                          });
                        },
                      ),
                    ),
                    RichText(
                      maxLines: 10,
                      text: TextSpan(
                        text: 'I have read and accept ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'terms and \nconditions',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewContainer(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                NunutButton(
                  backgroundColor: agree ? nunutPrimaryColor : Colors.grey,
                  isDisabled: agree ? false : true,
                  title: "Daftar",
                  widthButton: 200,
                  onPressed: agree
                      ? () {
                          //all field must be filled
                          if (email.text.isNotEmpty && fullName.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty && nik.text.isNotEmpty && noTelp.text.isNotEmpty) {
                            final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text); // check email valid or not
                            if (emailValid) {
                              if (password.text.length >= 8) {
                                if (password.text == confirmPassword.text) {
                                  Future.delayed(
                                    Duration(seconds: 3),
                                    () async {
                                      AuthService.signUp(
                                        email: email.text,
                                        name: fullName.text,
                                        nik: nik.text,
                                        password: password.text,
                                        phone: noTelp.text,
                                      );

                                      Fluttertoast.showToast(
                                          msg: "Akun berhasil dibuat, silahkan login menggunakan akun yang telah dibuat!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Future.delayed(
                                        Duration(seconds: 2),
                                        () {
                                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Password tidak sama",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Password minimal 8 karakter",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Email tidak ditulis dengan benar",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Semua field harus diisi",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
