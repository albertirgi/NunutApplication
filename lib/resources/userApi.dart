import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:http/http.dart' as http;

CollectionReference collectionRef = FirebaseFirestore.instance.collection("users");

class UserService {
  Future<void> tambahData({required UserModel user, required UserCredential userCredential}) async {
    DocumentReference docRef = collectionRef.doc(userCredential.user!.uid);

    await docRef.set(user.toJson()).whenComplete(() => print("Data Berhasil Ditambahkan")).catchError((e) => print(e.toString()));
  }

  Future<UserModel> getUserByID(String id) async {
    try {
      DocumentSnapshot snapshot = await collectionRef.doc(id).get();

      //get driver id by user id with https://ayonunut.com/api/v1/driver?user=BlL5wZXp8wMkbSKpIGXlAnZYKMJ3
      var url = Uri.parse("https://ayonunut.com/api/v1/driver?user=$id");
      var response = await http.get(url);

      Result result = Result.fromJson(json.decode(response.body));

      return UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        nik: snapshot['nik'],
        phone: snapshot['phone'],
        id: id,
        driverId: result.data[0]["driver_id"],
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser({required UserModel user}) async {
    try {
      User? userAuth = FirebaseAuth.instance.currentUser;
      DocumentReference docRef = collectionRef.doc(userAuth!.uid);
      print(userAuth.uid);
      print(user.name.toString());

      await docRef.update(user.toJson()).whenComplete(() => print("Data Berhasil Diupdate")).catchError((e) => print(e.toString()));
    } catch (e) {
      throw e;
    }
  }
}
