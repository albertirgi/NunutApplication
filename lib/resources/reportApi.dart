import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mreport.dart';

class ReportApi {

  static Future PostReport(title, description,ride_request_id, user_id) async {
    var url = Uri.parse(config.baseUrl + '/report/');
    var response = await http.post(url, body: {
      'title': title,
      'description': description,
      'ride_request_id': ride_request_id,
      'user_id': user_id,
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

  Future<List<ReportModel>> getReportList() async {
    var url = Uri.parse(config.baseUrl + '/report');
    var response = await http.get(url);

    Result result;
    List<ReportModel> reportList = [];
    //log("url : " + url.toString());

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      //log("isi result " + result.data.toString());
      result.data.forEach((item) {
        //log("isi item " + item.toString());
        reportList.add(ReportModel.fromJson(item));
        //log("isi reportList " + reportList[0].title.toString());
      });
      //log("isi reportList " + reportList.toString());
    }

    return reportList;
  }
}

final reportApi = ReportApi();