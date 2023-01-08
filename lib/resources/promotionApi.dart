import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mpromotion.dart';

class PromotionApi {
  Future<List<Promotion>> getPromotionList() async {
    var url = Uri.parse(config.baseUrl + '/voucher');
    var response = await http.get(url);

    Result result;
    List<Promotion> PromotionList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        PromotionList.add(Promotion.fromJson(item));
      });
    }
    return PromotionList;
  }
}

final promotionApi = PromotionApi();
