import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/reportApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../widgets/nunutTextFormField.dart';

class PengaduanKendalaPage extends StatefulWidget {
  const PengaduanKendalaPage({super.key});

  @override
  State<PengaduanKendalaPage> createState() => _PengaduanKendalaPageState();
}

class _PengaduanKendalaPageState extends State<PengaduanKendalaPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final user_id = config.user.id;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final rideSchedule = arguments["rideSchedule"] as RideSchedule?;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 10, right: 10),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 0, 7),
                    child: NunutText(
                      title: "Pengaduan Kendala",
                      size: 32,
                      isTitle: true,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: NunutTextFormField(
                      title: "Judul",
                      hintText: "Masukkan Judul Pengaduan",
                      obsecureText: false,
                      controller: title,
                      width: 1.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Deskripsi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromARGB(255, 204, 204, 204),
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: description,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Deskripsi Pengaduan",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: nunutPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          var status_post = await ReportApi.PostReport(title.text.toString(), description.text.toString(), rideSchedule!.id, user_id.toString());
                          if (status_post) {
                            Navigator.pushNamed(context, '/success', arguments: {
                              'title': "Pengaduan Kendala Berhasil Terkirim!",
                              'description': "Mohon menunggu balasan dari Nunut pada email anda!",
                            });
                            setState(() {
                              title.text = "";
                              description.text = "";
                            });
                          } else {
                            Fluttertoast.showToast(msg: "Laporan Gagal Terkirim");
                          }
                        },
                        child: Text(
                          "Kirim Pengaduan",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
