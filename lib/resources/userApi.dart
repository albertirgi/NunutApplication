import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:http/http.dart' as http;
import 'package:nunut_application/resources/authApi.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mwallet.dart';

CollectionReference collectionRef = FirebaseFirestore.instance.collection("users");
CollectionReference walletRef = FirebaseFirestore.instance.collection("wallet");

class UserService {
  Future<void> tambahData({required UserModel user, required UserCredential userCredential}) async {
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
      // DocumentSnapshot snapshot = await collectionRef.doc(id).get();
      var urlUser = Uri.parse("https://ayonunut.com/api/v1/user/$id");
      var responseUser = await http.get(
        urlUser,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${config.user.token}',
        },
      );
      var url = Uri.parse("https://ayonunut.com/api/v1/driver-user/$id");
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${config.user.token}',
        },
      );

      Wallet walletData = await MidtransApi.getWallet(id);
      Result result = Result.fromJson(json.decode(response.body));
      Result resultUser = Result.fromJson(json.decode(responseUser.body));

      return UserModel(
        email: resultUser.status == 200 ? resultUser.data["email"] : "empty",
        name: resultUser.status == 200 ? resultUser.data["name"] : "empty",
        nik: resultUser.status == 200 ? resultUser.data["nik"] : "empty",
        phone: resultUser.status == 200 ? resultUser.data["phone"] : "empty",
        photo: resultUser.status == 200 ? resultUser.data["image"] : "empty",
        id: id,
        driverId: result.status == 200 ? result.data["driver_id"] : "empty",
        wallet: priceFormat(walletData.balance.toString()),
        // token: _token,
        token: config.user.token,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser({required UserModel user, File? profile_picture}) async {
    try {
      User? userAuth = FirebaseAuth.instance.currentUser;
      DocumentReference docRef = collectionRef.doc(userAuth!.uid);
      var url = Uri.parse(config.baseUrl + '/user/' + userAuth.uid);
      var request = http.MultipartRequest('PUT', url);
      request.fields['name'] = user.name.toString();
      // request.fields['email'] = user.email.toString();
      request.fields['phone'] = user.phone.toString();
      request.fields['nik'] = user.nik.toString();
      request.fields['user_id'] = userAuth.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (profile_picture != null) {
        request.files.add(
          await http.MultipartFile(
            'image',
            profile_picture.readAsBytes().asStream(),
            profile_picture.lengthSync(),
            filename: profile_picture.path.split('/').last,
          ),
        );
      } else {
        if (config.user.photo != "empty" && config.user.photo != "" && config.user.photo != null) {
          request.fields['image'] = config.user.photo.toString();
        } else {
          request.fields['image'] = "https://firebasestorage.googleapis.com/v0/b/nunut-da274.appspot.com/o/avatar.png?alt=media&token=62dfdb20-7aa0-4ca4-badf-31c282583b1b";
        }
      }

      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      });

      var response = await request.send();
      String responseString = await response.stream.bytesToString();
      Map<String, dynamic> data = json.decode(responseString);
      UserModel newUser = UserModel(
        email: data['data']['email'],
        name: data['data']['name'],
        nik: data['data']['nik'],
        phone: data['data']['phone'],
        photo: data['data']['image'],
        id: config.user.id,
        driverId: config.user.driverId,
        wallet: config.user.wallet,
        token: config.user.token,
      );
      config.user = newUser;

      // await docRef
      //     .update(user.toJson())
      //     .whenComplete(() => print("Data Berhasil Diupdate"))
      //     .catchError((e) => print(e.toString()));
    } catch (e) {
      throw e;
    }
  }
}
