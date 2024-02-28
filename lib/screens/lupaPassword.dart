import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import '../widgets/nunutText.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
      Fluttertoast.showToast(
        msg: "Link reset password telah dikirim, mohon cek email anda untuk mereset password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        },
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: NunutText(title: "Lupa Password", isTitle: true, size: 32),
                ),
                InkWell(
                  child: NunutText(
                    title: "Masukkan email anda untuk mengubah password",
                    size: 15,
                    color: greyFontColor,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  ),
                ),
                NunutTextFormField(
                  title: "",
                  hintText: "Example@email.com",
                  obsecureText: false,
                  controller: email,
                  width: 1.5,
                ),
             
                NunutButton(
                  title: "Ubah Password",
                  widthButton: 200,
                  onPressed: passwordReset, 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
