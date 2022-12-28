import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

import 'package:nunut_application/models/mrideschedule.dart';

class RideScheduleApi {
  Future<List<RideSchedule>> getRideScheduleList() async {
    var url = Uri.parse(baseUrl + '/ride-schedule');
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
}

final rideScheduleApi = RideScheduleApi();