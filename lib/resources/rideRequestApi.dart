import 'dart:convert';

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

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

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

  Future<bool> deleteRideRequestById({required String rideRequestId, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/rde-request/$rideRequestId');
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );
    if (checkUrl) print(url);

    Result result;
    print("BAMBANG : " + json.encode(response.body));
    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RideSchedule>> getOrderList({String parameter = "", bool checkUrl = false, int page = 0}) async {
    String _parameter = "";
    if (page > 0) _parameter = "/list/$page";
    if (parameter.isNotEmpty) _parameter += "?$parameter";
    var url = Uri.parse(config.baseUrl + '/ride-request' + _parameter);

    if (checkUrl) print(url);

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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

  //post ride request
  Future<bool> addRideRequest({required String rideScheduleId, required String status_ride, required String user_id, bool checkUrl = false, String voucherId = ""}) async {
    var url = Uri.parse(config.baseUrl + '/ride-request');

    if (checkUrl) print(url);
    var body = jsonEncode({
      "ride_schedule_id": rideScheduleId,
      "status_ride": status_ride,
      "user_id": user_id,
    });

    if (voucherId.isNotEmpty)
      body = jsonEncode({
        "ride_schedule_id": rideScheduleId,
        "status_ride": status_ride,
        "user_id": user_id,
        "voucher_id": voucherId,
      });

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${config.user.token}",
      },
      body: body,
    );

    Result result;

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeStatusRideRequest({required String rideRequestId, required String status, bool checkUrl = false}) async {
    var url = Uri.parse(config.baseUrl + '/ride-request/status/$rideRequestId/$status');

    if (checkUrl) print(url);
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${config.user.token}",
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

final rideRequestApi = RideRequestApi();
