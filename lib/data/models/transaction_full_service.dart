import 'package:tikom/data/models/media.dart';
import 'package:tikom/data/models/product.dart';

class NewTransactionFullService {
  final dynamic full_service;
  final dynamic product;
  final Map<String, List<String>>? add_on;
  final dynamic custom_cup_name;
  final dynamic custom_cup_notes;

  NewTransactionFullService({
    this.full_service,
    this.add_on,
    this.product,
    this.custom_cup_name,
    this.custom_cup_notes,
  });

  factory NewTransactionFullService.fromJson(Map<String, dynamic> json) {
    return NewTransactionFullService(
      full_service: json['full)_service'],
      add_on: json['add_on'],
      product: json['product'],
      custom_cup_name: json['custom_cup_name'],
      custom_cup_notes: json['custom_cup_notes'],
    );
  }
}

class TransactionFullServiceStoreResponse {
  final String status;
  late String message;

  TransactionFullServiceStoreResponse(
      {required this.status, required this.message});

  factory TransactionFullServiceStoreResponse.fromJson(
          Map<String, dynamic> json) =>
      TransactionFullServiceStoreResponse(
        status: json['status'],
        message: json["msg"],
      );
}
