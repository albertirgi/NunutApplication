class RideSchedule {
  String? date;
  String? time;
  String? userId;
  int? price;

  RideSchedule({
    this.date,
    this.time,
    this.userId,
    this.price,
  });

  factory RideSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return RideSchedule(
      date: parsedJson["date"] as String? ?? "",
      time: parsedJson["time"] as String? ?? "",
      userId: parsedJson["userId"] as String? ?? "",
      price: parsedJson["price"] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['userId'] = this.userId;
    data['price'] = this.price;
    return data;
  }
}
