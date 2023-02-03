import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mparkingbuilding.dart';

class ParkingBuildingApi {
  Future<List<ParkingBuildingModel>>
      getParkingBuildingAndParkingSlotByParkingPlaceId(String id) async {
    var url = Uri.parse(config.baseUrl +
        '/parking-building?parking_place=' +
        id +
        '&parking_slot');
    var response = await http.get(url);

    Result result;
    List<ParkingBuildingModel> parkingBuildingList = [];
    //log("url : " + url.toString());

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      //log("isi result " + result.data.toString());
      result.data.forEach((item) {
        //log("isi item " + item.toString());
        parkingBuildingList.add(ParkingBuildingModel.fromJson(item));
        //log("isi parkingBuildingList " + parkingBuildingList[0].title.toString());
      });
      //log("isi parkingBuildingList " + parkingBuildingList.toString());
    }

    return parkingBuildingList;
  }
}

final parkingBuildingApi = ParkingBuildingApi();
