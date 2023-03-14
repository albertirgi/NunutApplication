import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

import 'package:nunut_application/models/mnotification.dart';

class NotificationApi {
  Future<List<NotificationModel>> getNotificationList() async {
    var url = Uri.parse(config.baseUrl + '/notification');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<NotificationModel> notificationList = [];

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      result.data.forEach((item) {
        notificationList.add(NotificationModel.fromJson(item));
      });
    }

    return notificationList;
  }
}

final notificationApi = NotificationApi();
