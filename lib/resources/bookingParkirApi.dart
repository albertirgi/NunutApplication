import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

class BookingParkirApi {
  static Future SendBookingParkir(id_parking_slot, id_ride_order) async {
    var url = Uri.parse(config.baseUrl + '/parking-request/');
    var urlUpdateStatus = Uri.parse(config.baseUrl + '/parking-slot/');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: {
        'parking_slot_id': id_parking_slot,
        'ride_schedule_id': id_ride_order,
      },
    );

    Result result;
    result = Result.fromJson(json.decode(response.body.toString()));
    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future UpdateStatusSlotParkir(id_parking_slot) async {
    var urlUpdateStatus = Uri.parse(config.baseUrl + '/parking-slot/' + id_parking_slot);
    var responseUpdateStatus = await http.put(
      urlUpdateStatus,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: {
        'status': "false",
      },
    );

    Result resultUpdateStatus;
    resultUpdateStatus = Result.fromJson(json.decode(responseUpdateStatus.body.toString()));
    if (resultUpdateStatus.status == 200) {
      return true;
    } else {
      return false;
    }
  }
}

final bookingParkirApi = BookingParkirApi();
