// To parse this JSON data, do
//
//     final parkingPlace = parkingPlaceFromJson(jsonString);

import 'dart:convert';

ParkingPlace parkingPlaceFromJson(String str) => ParkingPlace.fromJson(json.decode(str));

String parkingPlaceToJson(ParkingPlace data) => json.encode(data.toJson());

class ParkingPlace {
    ParkingPlace({
        required this.message,
        required this.data,
        required this.status,
    });

    String message;
    List<ParkingPlaceModel> data;
    int status;

    factory ParkingPlace.fromJson(Map<String, dynamic> json) => ParkingPlace(
        message: json["message"],
        data: List<ParkingPlaceModel>.from(json["data"].map((x) => ParkingPlaceModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class ParkingPlaceModel {
    ParkingPlaceModel({
        required this.parkingPlaceId,
        required this.name,
        required this.image,
        required this.subName,
    });

    String parkingPlaceId;
    String name;
    String image;
    String subName;

    factory ParkingPlaceModel.fromJson(Map<String, dynamic> json) => ParkingPlaceModel(
        parkingPlaceId: json["parking_place_id"],
        name: json["name"],
        image: json["image"],
        subName: json["sub_name"],
    );

    Map<String, dynamic> toJson() => {
        "parking_place_id": parkingPlaceId,
        "name": name,
        "image": image,
        "sub_name": subName,
    };
}
