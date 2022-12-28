class Result {
  int status;
  String message;
  final data;
  // int? total;

  Result({
    required this.status,
    required this.message,
    this.data,
    // this.total
  });

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      status: parsedJson["status"] ?? 0,
      message: parsedJson["message"] ?? "",
      data: parsedJson["data"] ?? "",
      // total: parsedJson["total"] ?? 0,
    );
  }
}
