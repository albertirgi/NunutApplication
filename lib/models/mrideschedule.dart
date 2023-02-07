import 'package:nunut_application/models/mdriver.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/models/mvehicle.dart';

class RideSchedule {
  String? date;
  String? time;
  String? id;
  int? price;
  MapLocation? meetingPoint;
  MapLocation? destination;
  bool? isBookmarked;
  Driver? driver;
  dynamic vehicle;
  int? capacity;
  bool? isActive;

  RideSchedule({
    this.date,
    this.time,
    this.id,
    this.price,
    this.meetingPoint,
    this.destination,
    this.isBookmarked = false,
    this.driver,
    this.vehicle,
    this.capacity,
    this.isActive,
  });

  factory RideSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return RideSchedule(
      date: parsedJson["date"] as String? ?? "",
      time: parsedJson["time"] as String? ?? "",
      id: parsedJson["ride_schedule_id"] as String? ?? "",
      price: parsedJson["price"] as int? ?? 0,
      meetingPoint: parsedJson["meeting_point"] != null ? MapLocation.fromJson(parsedJson["meeting_point"]) : null,
      destination: parsedJson["destination"] != null ? MapLocation.fromJson(parsedJson["destination"]) : null,
      isBookmarked: parsedJson["is_bookmarked"] as bool? ?? false,
      driver: parsedJson["driver_id"] != null ? Driver.fromJson(parsedJson["driver_id"]) : null,
      vehicle: parsedJson["vehicle_id"] != null
          ? parsedJson["vehicle_id"].runtimeType == String
              ? parsedJson["vehicle_id"] as String? ?? ""
              : Vehicle.fromJson(parsedJson["vehicle_id"])
          : null,
      capacity: parsedJson["capacity"] as int? ?? 0,
      isActive: parsedJson["is_active"] as bool? ?? false,
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
    if (this.vehicle != null) {
      data['vehicle_id'] = this.vehicle!.toJson();
    }
    data['capacity'] = this.capacity;
    data['is_active'] = this.isActive;
    return data;
  }
}
