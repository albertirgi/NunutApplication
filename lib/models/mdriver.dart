import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    required this.driverId,
    required this.aggrementLetter,
    required this.drivingLicense,
    required this.name,
    required this.email,
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
  String email;
  String image;
  String nik;
  String phone;
  String status;
  String studentCard;
  String userId;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driver_id"],
        aggrementLetter: json["aggrement_letter"],
        drivingLicense: json["driving_license"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        nik: json["nik"],
        phone: json["phone"],
        status: json["status"],
        studentCard: json["student_card"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "agreement_letter": aggrementLetter,
        "driving_license": drivingLicense,
        "name": name,
        "email": email,
        "image": image,
        "nik": nik,
        "phone": phone,
        "status": status,
        "student_card": studentCard,
        "user_id": userId,
      };
}
