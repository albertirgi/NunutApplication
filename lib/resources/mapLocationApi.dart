import 'dart:convert';

import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:http/http.dart' as http;
import 'package:nunut_application/models/mresult.dart';

class MapLocationApi {
  Future<List<MapLocation>> getMapList({String parameter = "", bool checkUrl = false}) async {
    if (parameter.isNotEmpty) parameter = "?$parameter";
    var url = Uri.parse(config.baseUrl + '/map' + parameter);

    if (checkUrl) print(url);

    var response = await http.get(url);

    Result result;
    List<MapLocation> mapLocationList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        mapLocationList.add(MapLocation.fromJson(item));
      });
    }
    return mapLocationList;
  }
}

final mapLocationApi = MapLocationApi();
