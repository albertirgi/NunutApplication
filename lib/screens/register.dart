import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';

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
                  obsecureText: false,
                  controller: password,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "Konfirmasi Kata Sandi",
                  hintText: "Konfirmasi Kata Sandi ",
                  obsecureText: false,
                  controller: confirmPassword,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "NIK",
                  hintText: "NIK ",
                  obsecureText: false,
                  controller: nik,
                  width: 1.5,
                ),
                NunutTextFormField(
                  title: "Kata Sandi",
                  hintText: "Kata Sandi",
                  obsecureText: true,
                  controller: password,
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
                NunutButton(
                  title: "Daftar",
                  widthButton: 200,
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
