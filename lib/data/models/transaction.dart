class TransactionStoreResponse {
  final String status;
  dynamic token;
  String message;
  final String? error;

  TransactionStoreResponse({
    required this.status,
    this.token,
    required this.message,
    this.error
  });

  factory TransactionStoreResponse.fromJson(Map<String, dynamic> json) => TransactionStoreResponse(
    status: json['status'],
    message: json["msg"],
  );
}
