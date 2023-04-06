import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                          //icon chat
                          //Profile Picture
                          Container(
                            height: 90,
                            padding: const EdgeInsets.only(left: 40),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                CircleAvatar(
                                  //border circle avatar black
                                  backgroundColor: Colors.black,
                                  radius: 50,
                                  backgroundImage: _profilePicture == null
                                      ? NetworkImage("https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiO")
                                      : Image.file(_profilePicture!).image,
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
                                  // child: BorderedText(
                                  //   child: Text(
                                  //     "Data Diri",
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 38,
                                  //     ),
                                  //   ),
                                  //   strokeWidth: 3.0,
                                  //   strokeColor: Colors.black,
                                  // ),
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
                      // SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: Column(
                          children: [
                            // NunutTextFormField(
                            //   title: "Nama Lengkap",
                            //   hintText: "Nama Lengkap",
                            //   obsecureText: false,
                            //   controller: fullName,
                            //   width: 1.5,
                            // ),
                            // NunutTextFormField(
                            //   title: "NIK",
                            //   hintText: "NIK ",
                            //   obsecureText: false,
                            //   controller: nik,
                            //   width: 1.5,
                            // ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     NunutText(
                            //       title: "Nomor Telepon",
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     SizedBox(height: 2),
                            //     Row(
                            //       children: [
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(12),
                            //             border: Border.all(
                            //               color: Colors.black,
                            //               width: 1.5,
                            //             ),
                            //             //color: nunutPrimaryColor,
                            //           ),
                            //           child: Center(
                            //             child: NunutText(
                            //               title: "+62",
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ),
                            //         SizedBox(width: 10),
                            //         Expanded(
                            //           child: TextFormField(
                            //             cursorColor: Colors.black,
                            //             obscureText: false,
                            //             controller: noTelp,
                            //             decoration: InputDecoration(
                            //               hintText: "Nomor Telepon",
                            //               border: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12),
                            //                 borderSide: BorderSide(
                            //                   color: Colors.black,
                            //                   width: 1.5,
                            //                 ),
                            //               ),
                            //               focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12),
                            //                 borderSide: BorderSide(
                            //                   color: Colors.black,
                            //                   width: 1.5,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Container(
                      //   margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       NunutText(
                      //         title: "Data Kendaraan",
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               border: Border.all(
                      //                 color: Colors.black,
                      //                 width: 1.5,
                      //               ),
                      //               borderRadius: BorderRadius.circular(12),
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 //ogoKendaraan
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       10, 20, 10, 0),
                      //                   child: Image(
                      //                     image: AssetImage("assets/toyota.png"),
                      //                     height: 20,
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 5),
                      //                 //NamaKendaraan
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.fromLTRB(10, 0, 80, 0),
                      //                   child: NunutText(
                      //                     title: "Toyota",
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 //platnomor
                      //                 Padding(
                      //                   padding: const EdgeInsets.fromLTRB(
                      //                       10, 0, 10, 20),
                      //                   child: NunutText(
                      //                     title: "B 1234 ABC",
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Container(
                      //             margin: EdgeInsets.only(left: 10),
                      //             child: Column(
                      //               children: [
                      //                 //ogoKendaraan
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      //                   child: Icon(
                      //                     Icons.add_circle,
                      //                     color: Colors.black,
                      //                     size: 27,
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 5),
                      //                 //NamaKendaraan
                      //                 NunutText(
                      //                   title: "Tambah Kendaraan",
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // Container(
                      //   margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       NunutText(
                      //         title: "Persyaratan Berkas Driver",
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      // Container(
                      //   margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       NunutText(
                      //         title: "Surat Persetujuan",
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //       SizedBox(height: 2),
                      //       NunutButton(
                      //         title: aggrementLetterButtonTitle,
                      //         iconButton: Icon(Icons.file_upload, color: Colors.black),
                      //         heightButton: 45,
                      //         onPressed: () {
                      //           FilePicker.platform.pickFiles().then(
                      //             (value) {
                      //               FilePickerResult? result = value;
                      //               if (result != null) {
                      //                 File file = File(result.files.single.path!);
                      //                 setState(() {
                      //                   _aggrementLetter = file;
                      //                   aggrementLetterButtonTitle = WrappingFileName(result.files.single.name);
                      //                 });
                      //               } else {
                      //                 // User canceled the picker
                      //               }
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(child: Container()),
                      SizedBox(height: 100),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: NunutButton(
                          title: "Simpan Data",
                          onPressed: () async {
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
                              Navigator.pop(context);
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
