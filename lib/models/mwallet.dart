class Wallet {
  final String? id;
  final int? balance;
  final String? user_id;

  Wallet({
    this.id,
    this.balance,
    this.user_id,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"],
        user_id: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "user_id": user_id,
      };
}
