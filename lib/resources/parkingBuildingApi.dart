import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mparkingbuilding.dart';

class ParkingBuildingApi {
  Future<List<ParkingBuildingModel>> getParkingBuildingAndParkingSlotByParkingPlaceId(String id) async {
    var url = Uri.parse(config.baseUrl + '/parking-building?parking_place=' + id + '&parking_slot');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<ParkingBuildingModel> parkingBuildingList = [];

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      result.data.forEach((item) {
        parkingBuildingList.add(ParkingBuildingModel.fromJson(item));
      });
    }

    return parkingBuildingList;
  }
}

final parkingBuildingApi = ParkingBuildingApi();
