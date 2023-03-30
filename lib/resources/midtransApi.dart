import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mtransaction.dart';

import '../models/muser.dart';
import '../models/mwallet.dart';

class MidtransApi {
  static Future Topup(
    int gross_amount,
    String first_name,
    String last_name,
    String email,
    String phone,
    String user_id,
    String payment_type,
    String bank,
  ) async {
    var url = Uri.parse(config.baseUrl + '/topup/');
    var body = jsonEncode(<String, dynamic>{
      'gross_amount': gross_amount,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'user_id': user_id,
      "payment_type": payment_type,
      "bank": bank,
    });
    if (payment_type == "echannel") {
      body = jsonEncode(<String, dynamic>{
        'gross_amount': gross_amount,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'phone': phone,
        'user_id': user_id,
        "payment_type": payment_type,
        "echannel": {
          "bill_info1": "Topup",
          "bill_info2": "Nunut",
        },
      });
    } else if (payment_type == "permata") {
      body = jsonEncode(<String, dynamic>{
        'gross_amount': gross_amount,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'phone': phone,
        'user_id': user_id,
        "payment_type": payment_type,
      });
    }
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: body,
    );
    Map<String, dynamic> result = json.decode(response.body.toString());
    return result;
  }

  static Future handleTopup(String order_id, String payment_type, String status) async {
    var url = Uri.parse(config.baseUrl + '/handle-topup/');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': order_id,
        'payment_type': payment_type,
        'status': status,
      }),
    );
    Result result = Result.fromJson(json.decode(response.body.toString()));
    return result;
  }

  static Future getTransaction(String order_id) async {
    var url = Uri.parse(config.baseUrl + '/get-transaction/');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': order_id,
      }),
    );

    Map<String, dynamic> result = json.decode(response.body.toString());
    return result;
  }

  static Future getTransactionByWallet(String wallet_id) async {
    var url = Uri.parse(config.baseUrl + '/get-transaction-by-wallet/');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'wallet_id': wallet_id,
      }),
    );

    List<Transaction> result = [];
    Map<String, dynamic> data = json.decode(response.body.toString());
    if (data["data"] == null) return result;
    for (var i = 0; i < data["data"].length; i++) {
      result.add(Transaction.fromJson(data["data"][i]));
    }
    return result;
  }

  static Future getWallet(String user_id) async {
    var url = Uri.parse(config.baseUrl + '/get-wallet-balance/');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': user_id,
      }),
    );
    Map<String, dynamic> data = json.decode(response.body.toString());
    Wallet result = Wallet.fromJson(data["data"]);
    return result;
  }

  static Future storeBeneficiary(String name, String bank, String account_number) async {
    var url = Uri.parse(config.baseUrl + '/beneficiary/');
    UserModel user = await config.user;
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'bank': bank,
        'account': account_number,
        'alias_name': user.id.toString(),
        'email': user.email,
      }),
    );
    Map<String, dynamic> data = json.decode(response.body.toString());
    Result result = Result.fromJson(data);
    return result;
  }

  static Future getBeneficiaries({String param = ""}) async {
    var url = Uri.parse(config.baseUrl + '/beneficiary?' + param);
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${config.user.token}',
    });
    if (response.statusCode != 200) return {"status": "500", "message": "Something went wrong"};
    Map<String, dynamic> data = json.decode(response.body.toString());
    return data;
  }

  static Future storePayout(String beneficiary_id, int amount) async {
    var url = Uri.parse(config.baseUrl + '/payout/');
    UserModel user = await config.user;
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'beneficiary_id': beneficiary_id,
        'amount': amount,
        'user_id': user.id,
      }),
    );
    Map<String, dynamic> data = json.decode(response.body.toString());
    Result result = Result.fromJson(data);
    return result;
  }
}
