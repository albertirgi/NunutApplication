import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/models/muser.dart';

class RideRequest {
  String? id;
  RideSchedule? rideScheduleId;
  UserModel? user;
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
      rideScheduleId: RideSchedule.fromJson(parsedJson["ride_schedule_id"]),
      user: UserModel.fromJson(parsedJson["user_id"]),
      status: parsedJson["status_ride"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ride_schedule_id'] = this.rideScheduleId;
    data['user_id'] = this.user;
    data['status_ride'] = this.status;
    return data;
  }
}
