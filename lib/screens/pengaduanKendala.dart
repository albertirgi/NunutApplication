import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/resources/reportApi.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../widgets/nunutTextFormField.dart';

class PengaduanKendalaPage extends StatefulWidget {
  const PengaduanKendalaPage({super.key});

  @override
  State<PengaduanKendalaPage> createState() => _PengaduanKendalaPageState();
}

class _PengaduanKendalaPageState extends State<PengaduanKendalaPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final rideRequestId = arguments["ride_request_id"] as String?;
    final rideScheduleId = arguments["ride_schedule_id"] as String?;
    final title = arguments["title"] as String?;
    final isiTitle = arguments["isiTitle"] as String? ?? null;
    final lockTitle = arguments["lockTitle"] as String? ?? "false";
    titleController.text = isiTitle ?? "";
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 0, 7),
                    child: NunutText(
                      title: title!,
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
                      controller: titleController,
                      width: 1.5,
                      enabled: lockTitle == "true" ? false : true,
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
                  NunutButton(
                    title: title == "Pengaduan Kendala" ? "Kirimkan Pengaduan" : "Ajukan " + title,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    borderColor: Colors.transparent,
                    onPressed: () async {
                      if (description.text.isNotEmpty) {
                        if (titleController.text.isNotEmpty) {
                          if (title == "Pengaduan Kendala") {
                            var status_post = await ReportApi.PostReport(titleController.text.toString(), description.text.toString(), rideRequestId, config.user.id.toString());
                            if (status_post) {
                              Navigator.pushNamed(context, '/success', arguments: {
                                'title': "Pengaduan Kendala Berhasil Terkirim!",
                                'description': "Mohon menunggu balasan dari Nunut pada email anda!",
                                'isSuccess': true,
                              });
                              setState(() {
                                titleController.text = "";
                                description.text = "";
                              });
                            } else {
                              Fluttertoast.showToast(msg: "Laporan Gagal Terkirim");
                            }
                          } else if (title == "Pembatalan Booking") {
                            rideRequestApi
                                .deleteRideRequestById(rideRequestId: rideRequestId.toString(), title: titleController.text.toString(), description: description.text.toString())
                                .then((value) {
                              if (value) {
                                Fluttertoast.showToast(msg: "Berhasil membatalkan booking");
                              } else {
                                Fluttertoast.showToast(msg: "Gagal membatalkan booking");
                              }
                              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                            });
                          } else {
                            rideScheduleApi
                                .deleteRideScheduleById(rideScheduleId: rideScheduleId.toString(), title: titleController.text.toString(), description: description.text.toString())
                                .then((value) {
                              if (value) {
                                Fluttertoast.showToast(msg: "Berhasil membatalkan tumpangan");
                              } else {
                                Fluttertoast.showToast(msg: "Gagal membatalkan tumpangan");
                              }
                              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                            });
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Judul tidak boleh kosong");
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Deskripsi tidak boleh kosong");
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
