// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nunut_application/theme.dart';
// import 'package:otp_autofill/otp_autofill.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:waste_application/main.dart';
import 'dart:io' show File, Platform;

import 'package:url_launcher/url_launcher.dart';

// import 'package:waste_application/pages/qrcode_detailpage.dart';
// import 'package:waste_application/pages/splash_drop.dart';
// import 'package:waste_application/services_and_dataclass/sv_mitra.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Icon flash_status = Icon(Icons.flash_on);
  Barcode? barcode;

  QRViewController? controller;
  List<File?> image = [null, null, null, null];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void reassamble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Future<dynamic> getImage_device(String namaImage, String option) async {
    final image = "";
    if (option == "kamera") {
      // XFile? pickedFile = await ImagePicker().pickImage(
      //     source: ImageSource.camera,
      //     maxHeight: 512,
      //     maxWidth: 512,
      //     imageQuality: 70);
      // if (pickedFile != null) {
      //   print("foto sudah masuk");
      //   setState(() {
      //     //image1 = File(pickedFile.path);
      //   });
      // }
    } else if (option == "galeri") {
      // final image = await ImagePicker().pickImage(
      //     source: ImageSource.gallery,
      //     maxWidth: 512,
      //     maxHeight: 512,
      //     imageQuality: 70);
      //     print("data dari galeri didapatkan");

      // XFile? pickedFile = await ImagePicker().pickImage(
      //     source: ImageSource.gallery,
      //     maxHeight: 512,
      //     maxWidth: 512,
      //     imageQuality: 70);
      // if (pickedFile != null) {
      //   print("foto sudah masuk");
      //   setState(() {
      //     //image1 = File(pickedFile.path);
      //   });
      // }

      //minus backend, set data
    }
  }

  //dokumentasi : Untuk bottom modal ada 2 disini, ketika user berhasil scan qr, dan ambil gambar option dari kamera, galeri, atau remove picture yang diupload
  Future<Widget> ModalOption(String judulModal, String tipe) async {
    //String namaMitraGet =  DataMitra.getSpecificMitraData(judulModal);
    //print("Nama mitra dicari : ${namaMitraGet}");
    if (tipe == "gambartake") {
      //dokumentasi : Pilihan antara gambar lokasi dari gallery, camera, dan remove picture
      //modal untuk ambil gambar
      return await showMaterialModalBottomSheet(
          // isScrollControlled: true,
          bounce: true,
          // expand: false,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              //https://stackoverflow.com/questions/52414629/how-to-update-state-of-a-modalbottomsheet-in-flutter
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        child: const Text(
                          "Picture Source",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 89, 95),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          await getImage_device("", "kamera");
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: const [
                              Icon(Icons.camera),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Camera"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        height: 1,
                        color: const Color.fromARGB(255, 240, 240, 240),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          await getImage_device("", "galeri");

                          setState(() {});
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: const [
                              Icon(Icons.picture_in_picture),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Take from gallery"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
    } else if (tipe == "standar") {
      //dokumentasi : Untuk upload foto, dan show nama mitra dari id qr code yang terscan
      //lihat nama mitra dan upload image
      bool sudahAdd = false;
      bool visibilityBuka = true;
      return await showMaterialModalBottomSheet(
          // isScrollControlled: true,
          bounce: true,
          // expand: false,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          controller!.resumeCamera();
                        },
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(),
                      ),
                    ],
                  ),
                );
              },
            );
          });
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //dokumentasi : Untuk ganti isi isi scan, button-button dari widget yang dibuild
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text("QR Code Scanner"),
          // ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQRView(context),
              //view result
              Positioned(bottom: 10, child: buildResult()),
              Positioned(
                top: 75,
                child: revisiControlButton(),
              ) //buat button flashlight, dll
            ],
          ),
        ));
  }

  Widget buildControlButtons() => Container(
        //container buat white border disekeliling icon camera, dan flip camera
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: ((context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off);
                  } else {
                    return Container();
                  }
                }),
              ),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: ((context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.switch_camera);
                  } else {
                    return Container();
                  }
                }),
              ),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            ),
          ],
        ),
      );

  Widget revisiControlButton() {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => print("oke"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  color: Colors.black,
                  icon: FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder: ((context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                            snapshot.data! ? Icons.flash_off : Icons.flash_on);
                      } else {
                        return Container();
                      }
                    }),
                  ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => print("oke"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: ((context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(Icons.switch_camera);
                      } else {
                        return Container();
                      }
                    }),
                  ),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildResult() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon.png",
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _launchURL(barcode!.code);
                  },
                  child: Text(
                    barcode != null
                        ? 'Result : ${barcode!.code}'
                        : "Scan QR Code Tumpangan Kamu",
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  //for scan box : overlay
  Widget buildQRView(BuildContext context) => QRView(
        //dokumentasi : Bisa diganti-ganti ukurannya
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: nunutPrimaryColor,
            borderWidth: 10,
            borderLength: 20, //length border sisi
            borderRadius: 10 //biar kelihatan rounded
            //cutOutSize: MediaQuery.of(context).size.width * 0.8 //75% of screen
            ),
      );

  void doNemu() {
    //dokumentasi : Function ketika menemukan di barcode, membuka nama mitra, dan tempat upload
    ModalOption(barcode!.code.toString(), "standar");
    controller!.pauseCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;

      controller.scannedDataStream.listen(
        (barcode) => setState(
          () {
            this.barcode = barcode;
            InkWell(
              onTap: () => _launchURL(barcode.code),
              child: Text(barcode.code.toString()),
            );
            //_launchURL(barcode.code.toString());
            //print('Result Barcode : ${barcode.code}');
          },
        ),
      );
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  _launchURL(c) async {
    var url = Uri.parse(c);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
