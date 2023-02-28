import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import '../models/mwallet.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users");
CollectionReference walletRef = FirebaseFirestore.instance.collection("wallet");

class UserService {
  Future<void> tambahData(
      {required UserModel user, required UserCredential userCredential}) async {
    DocumentReference docRef = collectionRef.doc(userCredential.user!.uid);

    await docRef.set({
      "email": user.email,
      "name": user.name,
      "nik": user.nik,
      "phone": user.phone,
    }).whenComplete(() {
      print("Data Berhasil Ditambahkan");
      walletRef.doc(userCredential.user!.uid).set({
        "balance": 0,
        "user_id": userCredential.user!.uid,
      });
    }).catchError((e) => print(e.toString()));
  }

  Future<UserModel> getUserByID(String id) async {
    try {
      DocumentSnapshot snapshot = await collectionRef.doc(id).get();

      var url = Uri.parse("https://ayonunut.com/api/v1/driver-user/$id");
      var response = await http.get(url);

      Wallet walletData = await MidtransApi.getWallet(id);
      double numValue = double.parse(walletData.balance.toString());
      NumberFormat currencyFormatter =
          NumberFormat.simpleCurrency(locale: "id", decimalDigits: 0, name: "");

      Result result = Result.fromJson(json.decode(response.body));
      return UserModel(
          email: snapshot['email'],
          name: snapshot['name'],
          nik: snapshot['nik'],
          phone: snapshot['phone'],
          id: id,
          driverId: result.status == 200 ? result.data["driver_id"] : "empty",
          wallet: currencyFormatter.format(numValue));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(
      {required UserModel user, required File profile_picture}) async {
    try {
      User? userAuth = FirebaseAuth.instance.currentUser;
      DocumentReference docRef = collectionRef.doc(userAuth!.uid);
      var url = Uri.parse(config.baseUrl + '/user');
      var request = http.MultipartRequest('PUT', url);
      print(userAuth.uid);
      print(user.name.toString());
      request.fields['name'] = user.name.toString();
      request.fields['email'] = user.email.toString();
      request.fields['phone'] = user.phone.toString();
      request.fields['nik'] = user.nik.toString();
      request.fields['user_id'] = userAuth.uid;

      request.files.add(
        await http.MultipartFile(
          'image',
          profile_picture.readAsBytes().asStream(),
          profile_picture.lengthSync(),
          filename: profile_picture.path.split('/').last,
        ),
      );

      var response = await request.send();
      print(response.stream.first.toString());

      // await docRef
      //     .update(user.toJson())
      //     .whenComplete(() => print("Data Berhasil Diupdate"))
      //     .catchError((e) => print(e.toString()));
    } catch (e) {
      throw e;
    }
  }
}
