// To parse this JSON data, do
//
//     final TncModel = TncModelFromJson(jsonString);

import 'dart:convert';

TncModel TncModelFromJson(String str) => TncModel.fromJson(json.decode(str));

String TncModelToJson(TncModel data) => json.encode(data.toJson());

class TncModel {
  TncModel({
    required this.definisi,
    required this.penyimpananDataPribadiUser,
    required this.persyaratanDanTataCara,
    required this.nunutPay,
    required this.transaksi,
    required this.nunutBerhak,
    required this.hakNnunut,
    required this.informasiKeamanan,
    required this.peralatan,
    required this.kebijakanPrivasi,
    required this.penyelesaianPerselisihan,
    required this.forceMajeure,
  });

  List<String> definisi;
  List<String> penyimpananDataPribadiUser;
  PersyaratanDanTataCara persyaratanDanTataCara;
  List<String> nunutPay;
  List<String> transaksi;
  List<String> nunutBerhak;
  List<String> hakNnunut;
  List<String> informasiKeamanan;
  List<String> peralatan;
  List<String> kebijakanPrivasi;
  List<String> penyelesaianPerselisihan;
  List<String> forceMajeure;

  factory TncModel.fromJson(Map<String, dynamic> json) => TncModel(
        definisi: List<String>.from(json["definisi"].map((x) => x)),
        penyimpananDataPribadiUser: List<String>.from(json["penyimpanan_data_pribadi_user"].map((x) => x)),
        persyaratanDanTataCara: PersyaratanDanTataCara.fromJson(json["persyaratan_dan_tata_cara"]),
        nunutPay: List<String>.from(json["nunut_pay"].map((x) => x)),
        transaksi: List<String>.from(json["transaksi"].map((x) => x)),
        nunutBerhak: List<String>.from(json["nunut_berhak"].map((x) => x)),
        hakNnunut: List<String>.from(json["hak_nnunut"].map((x) => x)),
        informasiKeamanan: List<String>.from(json["informasi_keamanan"].map((x) => x)),
        peralatan: List<String>.from(json["peralatan"].map((x) => x)),
        kebijakanPrivasi: List<String>.from(json["kebijakan_privasi"].map((x) => x)),
        penyelesaianPerselisihan: List<String>.from(json["penyelesaian_perselisihan"].map((x) => x)),
        forceMajeure: List<String>.from(json["force_majeure"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "definisi": List<dynamic>.from(definisi.map((x) => x)),
        "penyimpanan_data_pribadi_user": List<dynamic>.from(penyimpananDataPribadiUser.map((x) => x)),
        "persyaratan_dan_tata_cara": persyaratanDanTataCara.toJson(),
        "nunut_pay": List<dynamic>.from(nunutPay.map((x) => x)),
        "transaksi": List<dynamic>.from(transaksi.map((x) => x)),
        "nunut_berhak": List<dynamic>.from(nunutBerhak.map((x) => x)),
        "hak_nnunut": List<dynamic>.from(hakNnunut.map((x) => x)),
        "informasi_keamanan": List<dynamic>.from(informasiKeamanan.map((x) => x)),
        "peralatan": List<dynamic>.from(peralatan.map((x) => x)),
        "kebijakan_privasi": List<dynamic>.from(kebijakanPrivasi.map((x) => x)),
        "penyelesaian_perselisihan": List<dynamic>.from(penyelesaianPerselisihan.map((x) => x)),
        "force_majeure": List<dynamic>.from(forceMajeure.map((x) => x)),
      };
}

class PersyaratanDanTataCara {
  PersyaratanDanTataCara({
    required this.userDriver,
    required this.userPengguna,
  });

  List<String> userDriver;
  List<String> userPengguna;

  factory PersyaratanDanTataCara.fromJson(Map<String, dynamic> json) => PersyaratanDanTataCara(
        userDriver: List<String>.from(json["user_driver"].map((x) => x)),
        userPengguna: List<String>.from(json["user_pengguna"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_driver": List<dynamic>.from(userDriver.map((x) => x)),
        "user_pengguna": List<dynamic>.from(userPengguna.map((x) => x)),
      };
}
