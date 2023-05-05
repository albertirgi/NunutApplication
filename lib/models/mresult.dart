class Result {
  int status;
  String message;
  final data;

  Result({
    required this.status,
    required this.message,
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      status: parsedJson["status"] ?? 0,
      message: parsedJson["message"] ?? "",
      data: parsedJson["data"] ?? "",
    );
  }
}
