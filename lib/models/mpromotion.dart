class Promotion {
  String? id;
  String? code;
  String? expiredAt;
  String? minimum;
  String? maximum;
  String? image;
  List<dynamic>? tnc;

  Promotion({
    this.id,
    this.code,
    this.expiredAt,
    this.minimum,
    this.maximum,
    this.tnc,
    this.image,
  });

  factory Promotion.fromJson(Map<String, dynamic> parsedJson) {
    return Promotion(
      id: parsedJson["id"] as String? ?? "",
      code: parsedJson["code"] as String? ?? "",
      expiredAt: parsedJson["expired_at"] as String? ?? "",
      minimum: parsedJson["minimum"] as String? ?? "",
      maximum: parsedJson["maximum"] as String? ?? "",
      tnc: parsedJson["tnc"] as List<dynamic>? ?? [],
      image: parsedJson["image"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['expiredAt'] = this.expiredAt;
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['tnc'] = this.tnc;
    data['image'] = this.image;
    return data;
  }
}
