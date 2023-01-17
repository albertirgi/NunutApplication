import 'package:nunut_application/models/mdriver.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/models/muser.dart';

class Bookmark {
  String id;
  RideSchedule rideSchedule;
  UserModel user;
  Driver driver;

  Bookmark({
    required this.id,
    required this.rideSchedule,
    required this.user,
    required this.driver,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ride_schedule_id": rideSchedule,
      "user_id": user,
      "driver_id": driver,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      rideSchedule: RideSchedule.fromJson(json['ride_schedule_id']),
      user: UserModel.fromJson(json['user_id']),
      driver: Driver.fromJson(json['driver_id']),
    );
  }
}
