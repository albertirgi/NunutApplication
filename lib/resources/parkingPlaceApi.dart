import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mparkingplace.dart';


class ParkingPlaceApi {
  Future<List<ParkingPlaceModel>> getParkingPlace() async {
    var url = Uri.parse(config.baseUrl + '/parking-place');
    var response = await http.get(url);

    Result result;
    List<ParkingPlaceModel> parkingPlaceList = [];
    //log("url : " + url.toString());

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      //log("isi result " + result.data.toString());
      result.data.forEach((item) {
        //log("isi item " + item.toString());
        parkingPlaceList.add(ParkingPlaceModel.fromJson(item));
        //log("isi parkingPlaceList " + parkingPlaceList[0].title.toString());
      });
      //log("isi parkingPlaceList " + parkingPlaceList.toString());
    }

    return parkingPlaceList;
  }
}

final parkingPlaceApi = ParkingPlaceApi();