import 'dart:developer';

import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mvehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleApi {
  static Future<List<Vehicle2>> getVehicles() async {
    String driverId = "";
    if (config.user.driverId != "empty") {
      driverId = config.user.driverId!;
    } else {
      throw Exception('Failed to load vehicles: User is not a driver');
    }

    final response = await http.get(
      Uri.parse(config.baseUrl + '/vehicle?driver=' + driverId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      final vehicles = jsonMap['data'] as List;
      return vehicles.map((vehicle) => Vehicle2.fromJson(vehicle)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  static Future<List<VehicleType>> getVehicleTypes() async {
    final response = await http.get(
      Uri.parse(config.baseUrl + '/vehicle-type'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      final vehicleTypes = jsonMap['data'] as List;
      return vehicleTypes.map((vehicleType) {
        return VehicleType.fromJson(vehicleType);
      }).toList();
    } else {
      throw Exception('Failed to load vehicle types');
    }
  }

  static Future<Map<String, dynamic>> addVehicle(Vehicle2 vehicle) async {
    final response = await http.post(
      Uri.parse(config.baseUrl + '/vehicle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${config.user.token}',
      },
      body: jsonEncode(vehicle.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add vehicle');
    }
    return json.decode(response.body);
  }
}
