import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        email: email,
        name: name,
        nik: nik,
        phone: phone,
      );

      //send verification email
      await userCredential.user!.sendEmailVerification();

      final registeredUser = await UserService().tambahData(user: user, userCredential: userCredential).then((value) {
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
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel user = await UserService().getUserByID(userCredential.user!.uid);
      return user;
    } catch (e) {
      Fluttertoast.showToast(msg: "Password atau Email Salah", backgroundColor: nunutPrimaryColor, textColor: Colors.white);
      throw e;
    }
  }

  static Future<void> signOut() async {
    await auth.signOut().whenComplete(() => print("Berhasil Logout")).catchError((e) => print(e.toString()));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
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

  //gettoken
  static Future<String> getToken(String email, String password) async {
    var url = Uri.parse(config.baseUrl + '/login');
    var body = {
      'email': email,
      'password': password,
    };

    var response = await http.post(
      url,
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    Result result;
    String token = "";

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      token = result.data['token'];
    }
    return token;
  }
}
