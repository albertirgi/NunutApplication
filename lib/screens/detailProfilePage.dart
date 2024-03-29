import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';

import '../widgets/nunutText.dart';

class DetailProfilePage extends StatefulWidget {
  const DetailProfilePage({super.key});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    nik.dispose();
    noTelp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    fullName.text = user.name;
    nik.text = user.nik;
    noTelp.text = user.phone;
    UserService userService = UserService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      //icon chat
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 24, 0, 7),
                              child: NunutText(title: "Data Diri", isTitle: true, size: 32),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "Informasi Pribadi",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Profile Picture
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 90,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: CircleAvatar(
                                  //border circle avatar black
                                  backgroundColor: Colors.black,
                                  radius: 90,
                                  backgroundImage: _profilePicture == null
                                      ? config.user.photo == null
                                          ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/nunut-da274.appspot.com/o/avatar.png?alt=media&token=62dfdb20-7aa0-4ca4-badf-31c282583b1b")
                                          : NetworkImage(config.user.photo!)
                                      : Image.file(_profilePicture!).image,
                                ),
                              ),
                              //icon add bottom of image profile
                              Positioned(
                                bottom: -2,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    //upload image profile
                                    FilePicker.platform.pickFiles(type: FileType.image).then((value) {
                                      setState(() {
                                        _profilePicture = File(value!.files.single.path!);
                                      });
                                    });
                                  },
                                  child: Icon(Icons.add_circle, color: Colors.black, size: 27),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: Column(
                      children: [
                        NunutTextFormField(
                          title: "Nama Lengkap",
                          hintText: "Nama Lengkap",
                          obsecureText: false,
                          controller: fullName,
                          width: 1.5,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: NunutButton(
                      title: "Simpan Data",
                      onPressed: () {
                        userService.updateUser(user: UserModel(email: user.email, name: fullName.text, nik: nik.text, phone: noTelp.text), profile_picture: _profilePicture ?? null).then((value) {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
