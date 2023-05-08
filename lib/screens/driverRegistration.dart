import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/resources/driverApi.dart';
import 'package:nunut_application/resources/userApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/popUpLoading.dart';
import 'dart:io';
import '../models/muser.dart';
import '../widgets/nunutText.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

String WrappingFileName(String fileName) {
  if (fileName.length > 30) {
    return fileName.substring(0, 30) + "...";
  } else {
    return fileName;
  }
}

class _DriverRegistrationState extends State<DriverRegistration> {
  TextEditingController fullName = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController noTelp = TextEditingController();

  bool _isLoading = false;
  UserService userService = UserService();
  File? _ktmImage = null;
  String ktmButtonTitle = "Upload a file";
  File? _drivingLicense = null;
  String drivingLicenseButtonTitle = "Upload a file";
  File? _aggrementLetter = null;
  String aggrementLetterButtonTitle = "Upload a file";
  File? _profilePicture = null;

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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
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
                          Container(
                            height: 90,
                            padding: const EdgeInsets.only(left: 40),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 50,
                                  backgroundImage: config.user.photo != null
                                      ? NetworkImage(config.user.photo!)
                                      : (_profilePicture == null
                                          ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/nunut-da274.appspot.com/o/default.png?alt=media&token=c105adec-c241-423e-9e0f-cc992bb8408f")
                                          : Image.file(_profilePicture!).image),
                                ),
                                //icon add bottom of image profile
                                Positioned(
                                  bottom: -2,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      //upload image profile
                                      FilePicker.platform.pickFiles(type: FileType.image).then((value) {
                                        setState(() {
                                          if (value != null) {
                                            _profilePicture = File(value.files.single.path ?? "");
                                          }
                                        });
                                      });
                                    },
                                    child: Icon(Icons.add_circle, color: Colors.black, size: 27),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  child: NunutText(title: "Daftar Driver", isTitle: true, size: 32),
                                ),
                                SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    "Persyaratan Berkas Driver (Maksimal 8 MB)",
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
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Foto KTP",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2),
                            NunutButton(
                              title: ktmButtonTitle.length > 25 ? ktmButtonTitle.substring(0, 25) + "..." : ktmButtonTitle,
                              iconButton: Icon(Icons.file_upload, color: Colors.black),
                              heightButton: 45,
                              onPressed: () {
                                FilePicker.platform.pickFiles().then(
                                  (value) {
                                    FilePickerResult? result = value;
                                    if (result != null) {
                                      File file = File(result.files.single.path!);
                                      setState(() {
                                        _ktmImage = file;
                                        ktmButtonTitle = WrappingFileName(result.files.single.name);
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Surat Izin Mengemudi",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2),
                            NunutButton(
                              title: drivingLicenseButtonTitle.length > 25 ? drivingLicenseButtonTitle.substring(0, 25) + "..." : drivingLicenseButtonTitle,
                              iconButton: Icon(Icons.file_upload, color: Colors.black),
                              heightButton: 45,
                              onPressed: () {
                                FilePicker.platform.pickFiles().then(
                                  (value) {
                                    FilePickerResult? result = value;
                                    if (result != null) {
                                      File file = File(result.files.single.path!);
                                      setState(() {
                                        _drivingLicense = file;
                                        drivingLicenseButtonTitle = WrappingFileName(result.files.single.name);
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: NunutButton(
                          title: "Simpan Data",
                          onPressed: () async {
                            if (_ktmImage == null || _drivingLicense == null || (_profilePicture == null && (config.user.photo == "empty"))) {
                              Fluttertoast.showToast(
                                  msg: "Harap lengkapi semua data yang dibutuhkan termasuk foto profil",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return PopUpLoading(title: "Sedang Memproses...", subtitle: "Harap Menunggu...");
                                },
                              );
                            });
                            var res = await DriverApi.registerDriver(
                              fullName.text,
                              nik.text,
                              noTelp.text,
                              _ktmImage,
                              _drivingLicense,
                              _profilePicture,
                            );
                            if (res.status == 200) {
                              Fluttertoast.showToast(
                                  msg: "Pendaftaran driver berhasil. Silahkan tunggu konfirmasi dari admin",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              UserService service = UserService();
                              service.getUserByID(config.user.id!).then((value) {
                                config.user = value;
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Pendaftaran driver gagal. Silahkan coba lagi",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
