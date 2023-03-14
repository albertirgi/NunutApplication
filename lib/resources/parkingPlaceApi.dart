import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mparkingplace.dart';

class ParkingPlaceApi {
  Future<List<ParkingPlaceModel>> getParkingPlace() async {
    var url = Uri.parse(config.baseUrl + '/parking-place');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<ParkingPlaceModel> parkingPlaceList = [];

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      result.data.forEach((item) {
        parkingPlaceList.add(ParkingPlaceModel.fromJson(item));
      });
    }

    return parkingPlaceList;
  }
}

final parkingPlaceApi = ParkingPlaceApi();
