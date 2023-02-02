class MapLocation {
  String? mapId;
  String? name;
  String longitude;
  String latitude;

  MapLocation({
    this.mapId,
    this.name,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "map_id": mapId,
      "name": name,
      "longitude": longitude,
      "latitude": latitude,
    };
  }

  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      mapId: json['map_id'],
      name: json['name'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
}
