import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:nunut_application/theme.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {
  static Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String nik,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(
        email: email,
        name: name,
        nik: nik,
        phone: phone,
      );

      final registeredUser = await UserService()
          .tambahData(user: user, userCredential: userCredential)
          .then((value) {
        return UserService().getUserByID(userCredential.user!.uid);
      });
      return registeredUser;
    } catch (e) {
      throw e;
    }
  }

  static Future<UserModel> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user =
          await UserService().getUserByID(userCredential.user!.uid);
      return user;
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Password atau Email Salah",
          backgroundColor: nunutPrimaryColor,
          textColor: Colors.white);
      throw e;
    }
  }

  static Future<void> signOut() async {
    await auth
        .signOut()
        .whenComplete(() => print("Berhasil Logout"))
        .catchError((e) => print(e.toString()));
  }

  static Future<UserModel> getCurrentUser() async {
    try {
      User? user = auth.currentUser;
      UserModel userModel = await UserService().getUserByID(user!.uid);
      return userModel;
    } catch (e) {
      throw e;
    }
  }
}
