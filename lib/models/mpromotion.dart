class Promotion {
  String? id;
  String? code;
  String? expiredAt;
  int? minimum;
  String? title;
  String? tnc;

  Promotion({
    this.id,
    this.code,
    this.expiredAt,
    this.minimum,
    this.title,
    this.tnc,
  });

  factory Promotion.fromJson(Map<String, dynamic> parsedJson) {
    return Promotion(
      id: parsedJson["id"] as String? ?? "",
      code: parsedJson["code"] as String? ?? "",
      expiredAt: parsedJson["expiredAt"] as String? ?? "",
      minimum: parsedJson["minimum"] as int? ?? 0,
      title: parsedJson["title"] as String? ?? "",
      tnc: parsedJson["tnc"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['expiredAt'] = this.expiredAt;
    data['minimum'] = this.minimum;
    data['title'] = this.title;
    data['tnc'] = this.tnc;
    return data;
  }
}
