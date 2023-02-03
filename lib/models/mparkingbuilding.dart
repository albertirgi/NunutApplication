// To parse this JSON data, do
//
//     final parkingBuilding = parkingBuildingFromJson(jsonString);

import 'dart:convert';

ParkingBuilding parkingBuildingFromJson(String str) =>
    ParkingBuilding.fromJson(json.decode(str));

String parkingBuildingToJson(ParkingBuilding data) =>
    json.encode(data.toJson());

class ParkingBuilding {
  ParkingBuilding({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<ParkingBuildingModel> data;
  int status;

  factory ParkingBuilding.fromJson(Map<String, dynamic> json) =>
      ParkingBuilding(
        message: json["message"],
        data: List<ParkingBuildingModel>.from(
            json["data"].map((x) => ParkingBuildingModel.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class ParkingBuildingModel {
  ParkingBuildingModel({
    required this.parkingBuildingId,
    required this.name,
    required this.parkingPlaceId,
    required this.parkingSlot,
  });

  String parkingBuildingId;
  String name;
  ParkingPlaceId parkingPlaceId;
  List<ParkingSlot> parkingSlot;

  factory ParkingBuildingModel.fromJson(Map<String, dynamic> json) =>
      ParkingBuildingModel(
        parkingBuildingId: json["parking_building_id"],
        name: json["name"],
        parkingPlaceId: ParkingPlaceId.fromJson(json["parking_place_id"]),
        parkingSlot: List<ParkingSlot>.from(
            json["parkingSlot"].map((x) => ParkingSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parking_building_id": parkingBuildingId,
        "name": name,
        "parking_place_id": parkingPlaceId.toJson(),
        "parkingSlot": List<dynamic>.from(parkingSlot.map((x) => x.toJson())),
      };
}

class ParkingPlaceId {
  ParkingPlaceId({
    required this.parkingPlaceId,
    required this.name,
  });

  String parkingPlaceId;
  String name;

  factory ParkingPlaceId.fromJson(Map<String, dynamic> json) => ParkingPlaceId(
        parkingPlaceId: json["parking_place_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "parking_place_id": parkingPlaceId,
        "name": name,
      };
}

class ParkingSlot {
  ParkingSlot({
    required this.parkingSlotId,
    required this.status,
    required this.parkingBuildingId,
    required this.image,
    required this.instruction,
    required this.subtitle,
    required this.title,
  });

  String parkingSlotId;
  bool status;
  String parkingBuildingId;
  String image;
  List<String> instruction;
  String subtitle;
  String title;

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        parkingSlotId: json["parking_slot_id"],
        status: json["status"],
        parkingBuildingId: json["parking_building_id"],
        image: json["image"],
        instruction: List<String>.from(json["instruction"].map((x) => x)),
        subtitle: json["subtitle"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "parking_slot_id": parkingSlotId,
        "status": status,
        "parking_building_id": parkingBuildingId,
        "image": image,
        "instruction": List<dynamic>.from(instruction.map((x) => x)),
        "subtitle": subtitle,
        "title": title,
      };
}
