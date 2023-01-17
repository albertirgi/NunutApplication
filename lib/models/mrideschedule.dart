import 'package:nunut_application/models/mdriver.dart';
import 'package:nunut_application/models/mlocation.dart';

class RideSchedule {
  String? date;
  String? time;
  String? id;
  int? price;
  Location? meetingPoint;
  Location? destination;
  bool? isBookmarked;
  Driver? driver;

  RideSchedule({
    this.date,
    this.time,
    this.id,
    this.price,
    this.meetingPoint,
    this.destination,
    this.isBookmarked = false,
    this.driver,
  });

  factory RideSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return RideSchedule(
      date: parsedJson["date"] as String? ?? "",
      time: parsedJson["time"] as String? ?? "",
      id: parsedJson["ride_schedule_id"] as String? ?? "",
      price: parsedJson["price"] as int? ?? 0,
      meetingPoint: parsedJson["meeting_point"] != null ? Location.fromJson(parsedJson["meeting_point"]) : null,
      destination: parsedJson["destination"] != null ? Location.fromJson(parsedJson["destination"]) : null,
      isBookmarked: parsedJson["is_bookmarked"] as bool? ?? false,
      driver: parsedJson["driver_id"] != null ? Driver.fromJson(parsedJson["driver_id"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['ride_schedule_id'] = this.id;
    data['price'] = this.price;
    if (this.meetingPoint != null) {
      data['meeting_point'] = this.meetingPoint!.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
    }
    data['is_bookmarked'] = this.isBookmarked;
    if (this.driver != null) {
      data['driver_id'] = this.driver!.toJson();
    }
    return data;
  }
}
