import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mpromotion.dart';

class PromotionApi {
  Future<List<PromotionModel>> getPromotionList({bool checkURL = false}) async {
    var url = Uri.parse(config.baseUrl + '/voucher');
    if (checkURL) print(url);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<PromotionModel> PromotionList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        PromotionList.add(PromotionModel.fromJson(item));
      });
    }
    return PromotionList;
  }
}

final promotionApi = PromotionApi();
