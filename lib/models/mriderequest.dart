import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/models/muser.dart';

class RideRequest {
  String? id;
  dynamic rideScheduleId;
  dynamic user;
  String? status;

  RideRequest({
    this.id,
    this.rideScheduleId,
    this.user,
    this.status,
  });

  factory RideRequest.fromJson(Map<String, dynamic> parsedJson) {
    return RideRequest(
      id: parsedJson["ride_request_id"] as String? ?? "",
      rideScheduleId: parsedJson["ride_schedule_id"].runtimeType == String ? parsedJson["ride_schedule_id"] as String? ?? "" : RideSchedule.fromJson(parsedJson["ride_schedule_id"]),
      user: parsedJson["user_id"].runtimeType == String ? parsedJson["user_id"] as String? ?? "" : UserModel.fromJson(parsedJson["user_id"]),
      status: parsedJson["status_ride"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ride_schedule_id'] = this.rideScheduleId;
    data['user_id'] = this.user;
    data['status_ride'] = this.status;
    return data;
  }
}
