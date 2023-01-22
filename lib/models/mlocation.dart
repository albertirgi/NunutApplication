class Location {
  String? name;
  String logitude;
  String latitude;

  Location({
    this.name,
    required this.logitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "logitude": logitude,
      "latitude": latitude,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      logitude: json['logitude'],
      latitude: json['latitude'],
    );
  }
}
