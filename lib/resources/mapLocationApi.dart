import 'dart:convert';
import 'dart:developer';

import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:http/http.dart' as http;
import 'package:nunut_application/models/mresult.dart';

class MapLocationApi {
  Future<List<MapLocation>> getMapList({String parameter = "", bool checkUrl = false, int page = 0}) async {
    String _parameter = "";
    if (page > 0) _parameter = "/list/$page";
    if (parameter.isNotEmpty) _parameter += "?$parameter";
    var url = Uri.parse(config.baseUrl + '/map' + _parameter);

    if (checkUrl) print(url);

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

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

  Future<MapLocation> getMapListById(String id) async {
    var url = Uri.parse(config.baseUrl + '/map/' + id);

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    MapLocation mapLocation = MapLocation(longitude: "", latitude: "");

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      mapLocation = MapLocation.fromJson(result.data);
    }
    return mapLocation;
  }

  static Future<MapLocation> getMapUkp() async {
    var url = Uri.parse(config.baseUrl + '/map-petra/');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    MapLocation mapLocation = MapLocation(longitude: "", latitude: "");

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      mapLocation = MapLocation.fromJson(result.data[0]);
    }
    return mapLocation;
  }
}

final mapLocationApi = MapLocationApi();
