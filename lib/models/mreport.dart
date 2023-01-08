// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

Report? reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report? data) => json.encode(data!.toJson());

class Report {
    Report({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<ReportModel?>? data;
    int? status;

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        message: json["message"],
        data: json["data"] == null ? [] : List<ReportModel?>.from(json["data"]!.map((x) => ReportModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "status": status,
    };
}

class ReportModel {
    ReportModel({
        this.id,
        this.title,
        this.description,
        this.rideRequest,
        this.user,
    });

    String? id;
    String? title;
    String? description;
    String? rideRequest;
    String? user;

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        rideRequest: json["ride_request"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "ride_request": rideRequest,
        "user": user,
    };
}
