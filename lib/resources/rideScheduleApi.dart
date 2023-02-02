import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mbookmark.dart';
import 'package:nunut_application/models/mresult.dart';

import 'package:nunut_application/models/mrideschedule.dart';

class RideScheduleApi {
  static Future PostRideSchedule(
    date,
    time,
    meeting_point_long,
    meeting_point_lat,
    destination_long,
    destination_lat,
    vehicle_id,
    capacity,
    driver_id,
  ) async {
    var url = Uri.parse(config.baseUrl + '/ride-schedule/');
    var price = 10000;
    var meetingPoint = {"logitude": meeting_point_long, "latitude": meeting_point_lat};
    var destination = {"logitude": destination_long, "latitude": destination_lat};

    var response = await http.post(url, body: {
      'date': date,
      'time': time,
      'meeting_point': meetingPoint.toString(),
      'destination': destination.toString(),
      'note': "-",
      'vehicle_id': vehicle_id,
      'capacity': capacity,
      'driver_id': driver_id,
      'price': price.toString(),
      'name': "Testing",
      'is_active': "true",
    });
    //log("Response :" + response.body.toString());

    Result result;
    result = Result.fromJson(json.decode(response.body.toString()));
    //log("Result : " + result.status.toString());
    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RideSchedule>> getRideScheduleList({String parameter = "", bool checkUrl = false}) async {
    if (parameter.isNotEmpty) parameter = "?$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-schedule' + parameter);

    if (checkUrl) print(url);

    var response = await http.get(url);

    Result result;
    List<RideSchedule> rideScheduleList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        rideScheduleList.add(RideSchedule.fromJson(item));
      });
    }
    return rideScheduleList;
  }

  Future<bool> updateBookmark({required String rideScheduleId, required String userId}) async {
    var url = Uri.parse(config.baseUrl + '/bookmark/');
    var response = await http.post(
      url,
      body: {
        "ride_schedule_id": rideScheduleId,
        "user_id": userId,
      },
    );

    Result result;
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBookmarkByBookmarkId({required String bookmarkId, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/bookmark/$bookmarkId');
    var response = await http.delete(url);
    if (checkUrl) print(url);

    Result result;
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBookmarkByRideScheduleId({required String rideScheduleId, required String userId, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/bookmark?ride_schedule=$rideScheduleId&user=$userId');
    var response = await http.delete(url);
    if (checkUrl) print(url);

    Result result;
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Bookmark>> getBookmarkList({required String userId, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/bookmark?user=$userId&ride_schedule&driver');
    if (checkUrl) print(url);

    var response = await http.get(url);

    Result result;
    List<Bookmark> rideScheduleList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        rideScheduleList.add(Bookmark.fromJson(item));
      });
    }
    return rideScheduleList;
  }
}

final rideScheduleApi = RideScheduleApi();
