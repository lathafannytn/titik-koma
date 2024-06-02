import 'package:tikom/data/models/media.dart';
import 'package:tikom/data/models/product.dart';

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
  final int product_count;
  final List<ProductDetail> product_detail;
  final int price_discount;
  final int price_amount;
  final int down_payment;
  final String payment_type;
  final List<Media>? media;

  Transaction({
    required this.id,
    required this.uuid,
    required this.status,
    required this.price,
    required this.transaction_code,
    required this.service_date,
    required this.product_count,
    required this.product_detail,
    required this.price_amount,
    required this.price_discount,
    required this.payment_type,
    required this.down_payment,
    this.media,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List<dynamic>;
    List<ProductDetail> productDetails =
        productsJson.map((i) => ProductDetail.fromJson(i)).toList();

    // Check if 'media' is null and handle accordingly
    var mediaJson = json['media'] as List<dynamic>?;
    List<Media> mediaDetails = mediaJson != null
        ? mediaJson.map((i) => Media.fromJson(i)).toList()
        : [];

    return Transaction(
      id: json['id'].toString(),
      uuid: json['uuid'],
      status: json['status'],
      price: json['price'],
      product_count: json['product_count'],
      transaction_code: json['transaction_code'],
      product_detail: productDetails,
      price_amount: json['price_amount'],
      price_discount: json['price_discount'],
      payment_type: json['payment_type'],
      down_payment: json['down_payment'] ?? 0,
      service_date: json['service_date'],
      media: mediaDetails.isNotEmpty ? mediaDetails : null,
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
      'product_count': product_count,
      'product_detail':
          product_detail.map((product) => product.toJson()).toList(),
      'price_amount': price_amount,
      'price_discount': price_discount,
      'payment_type': payment_type,
      'down_payment': down_payment,
      'media': media?.map((m) => m.toJson()).toList(),
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
    List<Transaction> transactions =
        list.map((i) => Transaction.fromJson(i)).toList();

    return TransactionResponse(
      data: transactions,
      message: json['msg'],
      status: json['status'],
    );
  }
}
