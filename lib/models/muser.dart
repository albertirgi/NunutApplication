class UserModel {
  final String email;
  final String name;
  final String nik;
  final String phone;

  UserModel({
    required this.email,
    required this.name,
    required this.nik,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "nik": nik,
      "phone": phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      nik: json['nik'],
      phone: json['phone'],
    );
  }
}
