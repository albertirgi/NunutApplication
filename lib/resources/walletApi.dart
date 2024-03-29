import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/authApi.dart';

class WalletApi {
  static Future topup(int amount) async {
    UserModel user = await AuthService.getCurrentUser();
    var url = 'https://ayonunut.com/api/v1/topup2/';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: json.encode(
        {
          "user_id": user.id,
          "gross_amount": amount,
          "first_name": user.name,
          "last_name": "",
          "email": user.email,
          "phone": user.phone,
        },
      ),
    );
    if (response.statusCode == 200) {
      var result = json.decode(response.body.toString());
      return result['token'];
    } else {
      throw Exception('Failed to topup');
    }
  }
}
