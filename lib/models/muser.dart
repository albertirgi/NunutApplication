class UserModel {
  final String email;
  final String name;
  final String nik;
  final String phone;
  String? id;
  String? driverId;
  String? wallet;
  String? photo;
  String? token;
  String? driverStatus;

  UserModel({
    required this.email,
    required this.name,
    required this.nik,
    required this.phone,
    this.id,
    this.driverId,
    this.wallet,
    this.photo,
    this.token,
    this.driverStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "nik": nik,
      "phone": phone,
      "id": id,
      "driver_id": driverId,
      "wallet": wallet,
      "photo": photo,
      "token": token,
      "driver_status": driverStatus,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      nik: json['nik'],
      phone: json['phone'],
      id: json['id'],
      driverId: json['driverId'],
      wallet: json['wallet'],
      photo: json['photo'],
      token: json['token'],
    );
  }
}
