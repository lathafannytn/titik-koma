class TransactionStoreResponse {
  final String status;
  dynamic token;
  String message;
  final String? error;

  TransactionStoreResponse(
      {required this.status, this.token, required this.message, this.error});

  factory TransactionStoreResponse.fromJson(Map<String, dynamic> json) =>
      TransactionStoreResponse(
        status: json['status'],
        message: json["msg"],
      );
}

class Transaction {
  final String id;
  final String uuid;
  final String status;
  final dynamic price;
  final String transaction_code;
  final String service_date;

  Transaction({
    required this.id,
    required this.uuid,
    required this.status,
    required this.price,
    required this.transaction_code,
    required this.service_date,

  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'].toString(),
      uuid: json['uuid'],
      status: json['status'],
      price: json['price'],
      transaction_code: json['transaction_code'],
      service_date: json['service_date']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'status': status,
      'price': price,
      'transaction_code': transaction_code,
      'service_date': service_date,
    };
  }
}

class TransactionResponse {
  final String status;
  final String message;
  final List<Transaction> data;

  TransactionResponse(
      {required this.data, required this.status, required this.message});

   factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>;
    List<Transaction> transactions = list.map((i) => Transaction.fromJson(i)).toList();

    return TransactionResponse(
      data: transactions,
      message: json['msg'],
      status: json['status'],
    );
  }
}
