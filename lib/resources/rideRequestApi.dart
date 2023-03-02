import 'dart:convert';
import 'dart:developer';

import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mriderequest.dart';
import 'package:http/http.dart' as http;

import '../models/mrideschedule.dart';

class RideRequestApi {
  Future<List<RideRequest>> getRideRequestList({required String rideScheduleId, String parameter = "", bool checkUrl = false}) async {
    String _parameter = "";
    if (parameter.isNotEmpty) _parameter += "&$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-request?ride_schedule=${rideScheduleId}' + _parameter);

    if (checkUrl) print(url);

    var response = await http.get(url);

    Result result;
    List<RideRequest> rideRequestList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        rideRequestList.add(RideRequest.fromJson(item));
      });
    }
    return rideRequestList;
  }

  Future<List<RideSchedule>> getOrderList({String parameter = "", bool checkUrl = false, int page = 0}) async {
    String _parameter = "";
    if (page > 0) _parameter = "/list/$page";
    if (parameter.isNotEmpty) _parameter += "?$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-request' + _parameter);

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

  //post ride request
  Future<bool> addRideRequest({required String rideScheduleId, required String status_ride, required String user_id, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/ride-request');

    if (checkUrl) print(url);
    var body = jsonEncode({
      "ride_schedule_id": rideScheduleId,
      "status_ride": status_ride,
      "user_id": user_id,
    });
    print(body);
    // return true;

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    Result result;

    result = Result.fromJson(json.decode(response.body));
    print(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeStatusRideRequest({required String rideRequestId, required String status, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/ride-request/status/$rideRequestId/$status');

    if (checkUrl) print(url);
    var response = await http.get(url);

    Result result;
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }
}

final rideRequestApi = RideRequestApi();
