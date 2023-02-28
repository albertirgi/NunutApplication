import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mpromotion.dart';

class PromotionApi {
  Future<List<PromotionModel>> getPromotionList() async {
    var url = Uri.parse(config.baseUrl + '/voucher');
    var response = await http.get(url);

    Result result;
    List<PromotionModel> PromotionList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      log(result.data.toString());
      result.data.forEach((item) {
        log("isi item " + item.toString());
        PromotionList.add(PromotionModel.fromJson(item));
      });
    }
    return PromotionList;
  }
}

final promotionApi = PromotionApi();
