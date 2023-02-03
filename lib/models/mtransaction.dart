class Transaction {
  final String? id;
  final int? amount;
  final String? method;
  final String? order_id;
  final String? status;
  final String? transaction_id;
  final DateTime? transaction_time;
  final String? type;
  final String? wallet_id;

  Transaction({
    this.id,
    this.amount,
    this.method,
    this.order_id,
    this.status,
    this.transaction_id,
    this.transaction_time,
    this.type,
    this.wallet_id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["order_id"],
        amount: json["amount"],
        method: json["method"],
        order_id: json["order_id"],
        status: json["status"],
        transaction_id: json["transaction_id"],
        transaction_time: DateTime.fromMillisecondsSinceEpoch(
            json["transaction_time"]["_seconds"] * 1000),
        type: json["type"],
        wallet_id: json["wallet_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "method": method,
        "order_id": order_id,
        "status": status,
        "transaction_id": transaction_id,
        "transaction_time": transaction_time,
        "type": type,
        "wallet_id": wallet_id,
      };
}
