import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mreport.dart';

class ReportApi {
  static Future PostReport(title, description, ride_request_id, user_id) async {
    var url = Uri.parse(config.baseUrl + '/report/');
    var response = await http.post(
      url,
      body: {
        'title': title,
        'description': description,
        'ride_request_id': ride_request_id,
        'user_id': user_id,
      },
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
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

  Future<List<ReportModel>> getReportList() async {
    var url = Uri.parse(config.baseUrl + '/report');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<ReportModel> reportList = [];

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      result.data.forEach((item) {
        reportList.add(ReportModel.fromJson(item));
      });
    }

    return reportList;
  }
}

final reportApi = ReportApi();
