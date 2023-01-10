import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mresult.dart';
import 'package:nunut_application/models/mdriver.dart';

class DriverApi {
  Future<List<Driver>> getDriverList() async {
    var url = Uri.parse(config.baseUrl + '/driver');
    var response = await http.get(url);

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
    var response = await http.get(url);

    Result result;
    Driver driver = Driver(
        driverId: "",
        aggrementLetter: "",
        drivingLicense: "",
        name: "",
        email: "",
        image: "",
        nik: "",
        phone: "",
        status: "",
        studentCard: "",
        userId: "");

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
      await http.MultipartFile.fromPath(
          'aggrement_letter', driver.aggrementLetter),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
          'driving_license', driver.drivingLicense),
    );
    request.files.add(
      await http.MultipartFile.fromPath('student_card', driver.studentCard),
    );
    request.files.add(
      await http.MultipartFile.fromPath('image', driver.image),
    );
    var response = await request.send();
    print(response.statusCode);
  }
}
