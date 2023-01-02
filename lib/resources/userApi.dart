import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nunut_application/models/muser.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users");

class UserService {
  Future<void> tambahData(
      {required UserModel user, required UserCredential userCredential}) async {
    DocumentReference docRef = collectionRef.doc(userCredential.user!.uid);

    await docRef
        .set(user.toJson())
        .whenComplete(() => print("Data Berhasil Ditambahkan"))
        .catchError((e) => print(e.toString()));
  }

  Future<UserModel> getUserByID(String id) async {
    try {
      DocumentSnapshot snapshot = await collectionRef.doc(id).get();

      return UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        nik: snapshot['nik'],
        phone: snapshot['phone'],
      );
    } catch (e) {
      throw e;
    }
  }
}
