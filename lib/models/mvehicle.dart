class Vehicle {
  String? id;
  String? transportationType;
  String? licensePlate;

  Vehicle({
    this.id,
    this.transportationType,
    this.licensePlate,
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicle_id": id,
      "transportation_type": transportationType,
      "license_plate": licensePlate,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['vehicle_id'],
      transportationType: json['transportation_type'],
      licensePlate: json['license_plate'],
    );
  }
}

class Vehicle2 {
  String? id;
  String? color;
  String? driverId;
  String? licensePlate;
  String? expiredAt;
  String? transportationType;
  String? vehicleType;
  String? note;
  bool? isMain;

  Vehicle2({
    this.id,
    this.color,
    this.driverId,
    this.licensePlate,
    this.expiredAt,
    this.transportationType,
    this.vehicleType,
    this.note,
    this.isMain,
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicle_id": id,
      "color": color,
      "driver_id": driverId,
      "license_plate": licensePlate,
      "expired_at": expiredAt,
      "transportation_type": transportationType,
      "vehicle_type": vehicleType,
      "note": note,
      "is_main": isMain,
    };
  }

  factory Vehicle2.fromJson(Map<String, dynamic> json) {
    return Vehicle2(
      id: json['vehicle_id'],
      color: json['color'],
      driverId: json['driver_id'][0]['driver_id'],
      licensePlate: json['license_plate'],
      expiredAt: json['expired_at'],
      transportationType: json['transportation_type'],
      note: json['note'],
      isMain: json['is_main'],
    );
  }
}

class VehicleType {
  String? id;
  String? name;

  VehicleType({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicle_type_id": id,
      "name": name,
    };
  }

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json['vehicle_type_id'],
      name: json['name'],
    );
  }
}
