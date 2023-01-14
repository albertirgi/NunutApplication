import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

class MidtransApi {
  static Future Topup(int gross_amount, String first_name, String last_name,
      String email, String phone, String user_id) async {
    var url = Uri.parse(config.baseUrl + '/topup/');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'gross_amount': gross_amount,
          'first_name': first_name,
          'last_name': last_name,
          'email': email,
          'phone': phone,
          'user_id': user_id,
        }));
    Result result = Result.fromJson(json.decode(response.body.toString()));
    log("Response :" + response.body.toString());
    return result;
  }

  static Future handleTopup(
      String order_id, String payment_type, String status) async {
    var url = Uri.parse(config.baseUrl + '/handle-topup/');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'order_id': order_id,
          'payment_type': payment_type,
          'status': status,
        }));
    Result result = Result.fromJson(json.decode(response.body.toString()));
    return result;
  }
}
