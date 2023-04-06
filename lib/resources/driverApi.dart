import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mdriver.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/authApi.dart';

class DriverApi {
  Future<List<Driver>> getDriverList() async {
    var url = Uri.parse(config.baseUrl + '/driver');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    List<Driver> driverList = [];

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      result.data.forEach((item) {
        driverList.add(Driver.fromJson(item));
      });
    }
    return driverList;
  }

  Future<Driver> getDriverById(String id) async {
    var url = Uri.parse(config.baseUrl + '/driver/' + id);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );

    Result result;
    Driver driver = Driver(driverId: "", aggrementLetter: "", drivingLicense: "", name: "", email: "", image: "", nik: "", phone: "", status: "", studentCard: "", userId: "");

    result = Result.fromJson(json.decode(response.body));

    if (result.status == 200) {
      driver = Driver.fromJson(result.data[0]);
    }
    return driver;
  }

  Future<void> addDriver(Driver driver) async {
    var url = Uri.parse(config.baseUrl + '/driver');
    var request = http.MultipartRequest('POST', url);
    request.fields['name'] = driver.name;
    request.fields['email'] = driver.email;
    request.fields['phone'] = driver.phone;
    request.fields['nik'] = driver.nik;
    request.fields['status'] = driver.status;
    request.fields['user_id'] = driver.userId;
    request.files.add(
      await http.MultipartFile.fromPath('aggrement_letter', driver.aggrementLetter),
    );
    request.files.add(
      await http.MultipartFile.fromPath('driving_license', driver.drivingLicense),
    );
    request.files.add(
      await http.MultipartFile.fromPath('student_card', driver.studentCard),
    );
    request.files.add(
      await http.MultipartFile.fromPath('image', driver.image),
    );
    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${config.user.token}',
    });

    request.send();
  }

  static Future<Result> registerDriver(String fullname, String nik, String phone, File? ktmImage, File? drivingLicense, File? aggrementLetter) async {
    // Validate the form
    if (ktmImage == null || drivingLicense == null || aggrementLetter == null) {
      print("Please fill all the field");
      Result result = Result(status: 400, message: "Please fill all the field");
      return result;
    }
    var url = Uri.parse(config.baseUrl + '/driver');
    var request = http.MultipartRequest('POST', url);
    UserModel user = await AuthService.getCurrentUser();
    request.fields['name'] = user.name;
    request.fields['phone'] = user.phone;
    request.fields['nik'] = user.nik;
    request.fields['user_id'] = user.id!;
    request.fields['image'] = user.photo ?? "https://firebasestorage.googleapis.com/v0/b/nunut-da274.appspot.com/o/avatar.png?alt=media&token=62dfdb20-7aa0-4ca4-badf-31c282583b1b";
    request.files.add(
      http.MultipartFile(
        'aggrement_letter',
        aggrementLetter.readAsBytes().asStream(),
        aggrementLetter.lengthSync(),
        filename: aggrementLetter.path.split('/').last,
      ),
    );
    request.files.add(
      await http.MultipartFile(
        'driving_license',
        drivingLicense.readAsBytes().asStream(),
        drivingLicense.lengthSync(),
        filename: drivingLicense.path.split('/').last,
      ),
    );
    request.files.add(
      await http.MultipartFile(
        'student_card',
        ktmImage.readAsBytes().asStream(),
        ktmImage.lengthSync(),
        filename: ktmImage.path.split('/').last,
      ),
    );

    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${config.user.token}',
    });
    var response = await request.send();
    Result result = Result.fromJson(await response.stream.bytesToString().then((value) => json.decode(value)));
    return result;
  }
}
