import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mbookmark.dart';
import 'package:nunut_application/models/mresult.dart';

import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/mapLocationApi.dart';

class RideScheduleApi {
  static Future PostRideSchedule(date, time, meeting_point_id, destination_id, vehicle_id, capacity, driver_id) async {
    var url = Uri.parse(config.baseUrl + '/ride-schedule/');
    var price = 10000;
    var meetingPoint = await mapLocationApi.getMapListById(meeting_point_id);
    var destination = await mapLocationApi.getMapListById(destination_id);
    double startLat = double.parse(meetingPoint.latitude);
    double startLong = double.parse(meetingPoint.longitude);
    double endLat = double.parse(destination.latitude);
    double endLong = double.parse(destination.longitude);
    var distance = await startCalculate(startLat, startLong, endLat, endLong);
    var body = {
      'date': date,
      'time': time,
      'meeting_point': meetingPoint.toJson(),
      'destination': destination.toJson(),
      'note': "-",
      'vehicle_id': vehicle_id,
      'capacity': capacity,
      'driver_id': driver_id,
      'price': price,
      'is_active': true,
      'distance': distance,
    };
    var bodyJson = json.encode(body);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: bodyJson,
    );

    Result result = Result.fromJson(json.decode(response.body.toString()));
    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RideSchedule>> getRideScheduleList({String parameter = "", bool checkUrl = false, int page = 0}) async {
    String _parameter = "";
    if (page > 0) _parameter = "/list/$page";
    if (parameter.isNotEmpty) _parameter += "?$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-schedule' + _parameter);

    if (checkUrl) print(url);

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

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

  Future<RideSchedule> getRideScheduleById({String parameter = "", bool checkUrl = false, String id = ""}) async {
    String _parameter = "";
    if (parameter.isNotEmpty) _parameter += "?$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-schedule/$id' + _parameter);

    if (checkUrl) print(url);

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    RideSchedule rideSchedule = RideSchedule();

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      rideSchedule = RideSchedule.fromJson(result.data);
    }
    return rideSchedule;
  }

  Future<bool> deleteRideScheduleById({required String rideScheduleId, required String title, required String description, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/cancel-driver');
    var body = jsonEncode({
      "ride_schedule_id": rideScheduleId,
      "title": title,
      "description": description,
      "driver_id": config.user.driverId,
    });

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: body,
    );
    if (checkUrl) print(url);

    Result result;
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBookmark({required String rideScheduleId, required String userId}) async {
    var url = Uri.parse(config.baseUrl + '/bookmark/');
    var response = await http.post(
      url,
      body: {
        "ride_schedule_id": rideScheduleId,
        "user_id": userId,
      },
      headers: {
        'Authorization': 'Bearer ${config.user.token}',
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
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );
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
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );
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
    var url = Uri.parse(config.baseUrl + '/bookmark?ride_request&user=$userId&ride_schedule&driver&vehicle');
    if (checkUrl) print(url);

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

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

  static Future<bool> rideScheduleDone({required String rideScheduleId, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/ride-schedule/finish/' + rideScheduleId);
    if (checkUrl) print(url);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
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
}

final rideScheduleApi = RideScheduleApi();
