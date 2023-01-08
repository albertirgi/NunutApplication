import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    required this.driverId,
    required this.aggrementLetter,
    required this.drivingLicense,
    required this.name,
    required this.image,
    required this.nik,
    required this.phone,
    required this.status,
    required this.studentCard,
    required this.userId,
  });

  String driverId;
  String aggrementLetter;
  String drivingLicense;
  String name;
  String image;
  String nik;
  String phone;
  String status;
  String studentCard;
  String userId;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driverId"],
        aggrementLetter: json["aggrementLetter"],
        drivingLicense: json["drivingLicense"],
        name: json["name"],
        image: json["image"],
        nik: json["nik"],
        phone: json["phone"],
        status: json["status"],
        studentCard: json["studentCard"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "aggrementLetter": aggrementLetter,
        "drivingLicense": drivingLicense,
        "name": name,
        "image": image,
        "nik": nik,
        "phone": phone,
        "status": status,
        "studentCard": studentCard,
        "userId": userId,
      };
}
