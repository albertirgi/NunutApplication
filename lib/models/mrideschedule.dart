class RideSchedule {
  String? date;
  String? time;
  String? userId;
  int? price;
  bool? isBookmarked;

  RideSchedule({
    this.date,
    this.time,
    this.userId,
    this.price,
    this.isBookmarked = false,
  });

  factory RideSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return RideSchedule(
      date: parsedJson["date"] as String? ?? "",
      time: parsedJson["time"] as String? ?? "",
      userId: parsedJson["userId"] as String? ?? "",
      price: parsedJson["price"] as int? ?? 0,
      isBookmarked: parsedJson["is_bookmarked"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['userId'] = this.userId;
    data['price'] = this.price;
    data['is_bookmarked'] = this.isBookmarked;
    return data;
  }
}
