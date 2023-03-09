// To parse this JSON data, do
//
//     final promotion = promotionFromJson(jsonString);

import 'dart:convert';

Promotion promotionFromJson(String str) => Promotion.fromJson(json.decode(str));

String promotionToJson(Promotion data) => json.encode(data.toJson());

class Promotion {
  Promotion({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<PromotionModel> data;
  int status;

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        message: json["message"],
        data: List<PromotionModel>.from(json["data"].map((x) => PromotionModel.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class PromotionModel {
  PromotionModel({
    required this.voucherId,
    required this.code,
    required this.expiredAt,
    required this.minimumPuchase,
    required this.maximumDiscount,
    required this.tnc,
    required this.image,
    required this.type,
    required this.discount,
  });

  String voucherId;
  String code;
  String expiredAt;
  int minimumPuchase;
  int maximumDiscount;
  List<String> tnc;
  String image;
  String type;
  dynamic discount;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        voucherId: json["voucher_id"],
        code: json["code"],
        expiredAt: json["expired_at"],
        minimumPuchase: json["minimum_purchase"],
        maximumDiscount: json["maximum_discount"],
        tnc: List<String>.from(json["tnc"].map((x) => x)),
        image: json["image"],
        type: json["type"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "voucher_id": voucherId,
        "code": code,
        "expired_at": expiredAt,
        "minimum_puchase": minimumPuchase,
        "maximum_discount": maximumDiscount,
        "tnc": List<dynamic>.from(tnc.map((x) => x)),
        "image": image,
        "type": type,
        "discount": discount,
      };
}
