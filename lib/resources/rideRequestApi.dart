import 'dart:convert';

import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mriderequest.dart';
import 'package:http/http.dart' as http;

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
}

final rideRequestApi = RideRequestApi();
