// To parse this JSON data, do
//
//     final parkingSlot = parkingSlotFromJson(jsonString);

import 'dart:convert';

ParkingSlot parkingSlotFromJson(String str) => ParkingSlot.fromJson(json.decode(str));

String parkingSlotToJson(ParkingSlot data) => json.encode(data.toJson());

class ParkingSlot {
    ParkingSlot({
        required this.message,
        required this.data,
        required this.status,
    });

    String message;
    List<ParkingSlotModel> data;
    int status;

    factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        message: json["message"],
        data: List<ParkingSlotModel>.from(json["data"].map((x) => ParkingSlotModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class ParkingSlotModel {
    ParkingSlotModel({
        required this.parkingSlotId,
        required this.parkingBuildingId,
        required this.instruction,
        required this.image,
        required this.subtitle,
        required this.title,
        required this.status,
    });

    String parkingSlotId;
    String parkingBuildingId;
    List<String> instruction;
    String image;
    String subtitle;
    String title;
    bool status;

    factory ParkingSlotModel.fromJson(Map<String, dynamic> json) => ParkingSlotModel(
        parkingSlotId: json["parking_slot_id"],
        parkingBuildingId: json["parking_building_id"],
        instruction: List<String>.from(json["instruction"].map((x) => x)),
        image: json["image"],
        subtitle: json["subtitle"],
        title: json["title"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "parking_slot_id": parkingSlotId,
        "parking_building_id": parkingBuildingId,
        "instruction": List<dynamic>.from(instruction.map((x) => x)),
        "image": image,
        "subtitle": subtitle,
        "title": title,
        "status": status,
    };
}
