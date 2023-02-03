import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

class BookingParkirApi {

  static Future SendBookingParkir(id_parking_slot, id_ride_order) async {
    var url = Uri.parse(config.baseUrl + '/parking-request/');
    var response = await http.post(url, body: {
      'parking_slot_id': id_parking_slot,
      'ride_schedule_id': id_ride_order,
      
    });
    //log("Response :" + response.body.toString());

    Result result;
    result = Result.fromJson(json.decode(response.body.toString()));
    //log("Result : " + result.status.toString());
    if (result.status == 200) {
      return true;
    } else {
      return false;
    }
  }

}

final bookingParkirApi = BookingParkirApi();