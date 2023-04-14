import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../theme.dart';

class TermAndConsPage extends StatefulWidget {
  const TermAndConsPage({super.key});

  @override
  State<TermAndConsPage> createState() => _TermAndConsPageState();
}

class _TermAndConsPageState extends State<TermAndConsPage> {
  // print the parsed JSON data

  List dataKeseluruhan = [];

  List definisi = [];
  List penyimpanan_data_pribadi_user = [];
  List user_pengguna = [];
  List user_driver = [];
  List nunut_pay = [];
  List transaksi = [];
  List nunut_berhak = [];
  List hak_nnunut = [];
  List informasi_keamanan = [];
  List peralatan = [];
  List kebijakan_privasi = [];
  List penyelesaian_perselisihan = [];
  List force_majeure = [];
  @override
  void initState() {
    super.initState();
    _initDataJson();
  }

  _initDataJson() async {
    var read_json = await rootBundle.loadString('assets/tnc.json');
    var data = await json.decode(read_json);
    // log("data definisi: $data['definisi']");

    //log("data len : " + data["definisi"].length.toString());
    for (var i = 0; i < data["definisi"].length; i++) {
      definisi.add(data["definisi"][i]);
    }
    for (var i = 0; i < data["penyimpanan_data_pribadi_user"].length; i++) {
      penyimpanan_data_pribadi_user.add(data["penyimpanan_data_pribadi_user"][i]);
    }

    for (var i = 0; i < data["user_driver"].length; i++) {
      user_driver.add(data["user_driver"][i]);
    }
    for (var i = 0; i < data['user_pengguna'].length; i++) {
      user_pengguna.add(data['user_pengguna'][i]);
    }
    for (var i = 0; i < data["nunut_pay"].length; i++) {
      nunut_pay.add(data["nunut_pay"][i]);
    }
    for (var i = 0; i < data["transaksi"].length; i++) {
      transaksi.add(data["transaksi"][i]);
    }
    for (var i = 0; i < data["nunut_berhak"].length; i++) {
      nunut_berhak.add(data["nunut_berhak"][i]);
    }
    for (var i = 0; i < data["hak_nunut"].length; i++) {
      hak_nnunut.add(data["hak_nunut"][i]);
    }
    for (var i = 0; i < data["informasi_keamanan"].length; i++) {
      informasi_keamanan.add(data["informasi_keamanan"][i]);
    }
    for (var i = 0; i < data["peralatan"].length; i++) {
      peralatan.add(data["peralatan"][i]);
    }
    for (var i = 0; i < data["kebijakan_privasi"].length; i++) {
      kebijakan_privasi.add(data["kebijakan_privasi"][i]);
    }
    for (var i = 0; i < data["penyelesaian_perselisihan"].length; i++) {
      penyelesaian_perselisihan.add(data["penyelesaian_perselisihan"][i]);
    }
    for (var i = 0; i < data["force_majeure"].length; i++) {
      force_majeure.add(data["force_majeure"][i]);
    }

    log("data definisi: $definisi");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nunutPrimaryColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 24, left: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  child: Image.asset(
                    "assets/icon.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                NunutText(title: "Syarat dan Ketentuan", size: 24),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Definisi",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: definisi.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${definisi[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Penyimpanan Data Pribadi User",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: penyimpanan_data_pribadi_user.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${penyimpanan_data_pribadi_user[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Persyaratan dan Tata Cara",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NunutText(
                        title: "User Driver",
                        size: 16,
                        color: nunutPrimaryColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: user_driver.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${user_driver[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "User Penumpang",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: user_pengguna.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${user_pengguna[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Nunut Pay",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: nunut_pay.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index == 3
                                ? FutureBuilder(builder: (context, snapshot) {
                                    var numBaru = 1;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: transaksi.length,
                                      physics: ScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NunutText(
                                                title: "${numBaru++}. ${transaksi[index]}",
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  })
                                : SizedBox(),
                            index == 5
                                ? FutureBuilder(builder: (context, snapshot) {
                                    var numBaru = 1;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: nunut_berhak.length,
                                      physics: ScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NunutText(
                                                title: "${numBaru++}. ${nunut_berhak[index]}",
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  })
                                : SizedBox(),
                            index == 6
                                ? FutureBuilder(builder: (context, snapshot) {
                                    var numBaru = 1;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: hak_nnunut.length,
                                      physics: ScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NunutText(
                                                title: "${numBaru++}. ${hak_nnunut[index]}",
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  })
                                : SizedBox(),
                            NunutText(
                              title: "${num++}. ${nunut_pay[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Informasi Keamanan",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: informasi_keamanan.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index == 6
                                ? FutureBuilder(builder: (context, snapshot) {
                                    var numBaru = 1;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: peralatan.length,
                                      physics: ScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NunutText(
                                                title: "${numBaru++}. ${peralatan[index]}",
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  })
                                : SizedBox(),
                            NunutText(
                              title: "${num++}. ${informasi_keamanan[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Kebijakan Privasi",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: kebijakan_privasi.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${kebijakan_privasi[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Penyelesaian Perselisihan",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: penyelesaian_perselisihan.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${penyelesaian_perselisihan[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutText(
                      title: "Keadaan Kahar (Force Majeure)",
                      size: 16,
                      color: nunutPrimaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                FutureBuilder(builder: (context, snapshot) {
                  var num = 1;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: force_majeure.length,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "${num++}. ${force_majeure[index]}",
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
