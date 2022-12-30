import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';

import 'package:nunut_application/models/mnotification.dart';

class NotificationApi {
  Future<List<NotificationModel>> getNotificationList() async {
    var url = Uri.parse(baseUrl + '/notification');
    var response = await http.get(url);

    Result result;
    List<NotificationModel> notificationList = [];

    result = Result.fromJson(json.decode(response.body));
    if (result.status == 200) {
      //log("isi result " + result.data.toString());
      result.data.forEach((item) {
        //log("isi item " + item.toString());
        notificationList.add(NotificationModel.fromJson(item));
        //log("isi notificationList " + notificationList[0].title.toString());
      });
      //log("isi notificationList " + notificationList.toString());
    }

    return notificationList;
  }
}

final notificationApi = NotificationApi();
