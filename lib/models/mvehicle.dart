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
