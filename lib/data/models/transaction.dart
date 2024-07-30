import 'package:tikom/data/models/add_on_catering.dart';
import 'package:tikom/data/models/inventory_item.dart';
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
  final List<ProductDetailOrder> product_detail;
  final int price_discount;
  final int price_amount;
  final int down_payment;
  final String payment_type;
  final String point;
  final List<Media>? media;
  final BaseDelivery base_delivery;
  final dynamic is_fullservice;
  final List<AddOnCatering>? addOnCatering;
  final List<InventoryItem>? inventoryItems;

  final String? catering_name;
  final dynamic barista_count;
  final dynamic service_count;
  final dynamic custom_cup;
  final dynamic repayment;
  final dynamic repayment_date_count;
  final dynamic repayment_status;
  final dynamic repayment_date_last;



  Transaction(
      {required this.id,
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
      required this.point,
      required this.base_delivery,
      required this.is_fullservice,
      this.catering_name,
      this.barista_count,
      this.service_count,
      this.custom_cup,
      this.inventoryItems,
      this.repayment,
      this.addOnCatering,
      this.repayment_date_count,
      this.repayment_status,
      this.repayment_date_last,
    });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List<dynamic>;
    List<ProductDetailOrder> productDetails =
        productsJson.map((i) => ProductDetailOrder.fromJson(i)).toList();

    // Check if 'media' is null and handle accordingly
    var mediaJson = json['media'] as List<dynamic>?;
    List<Media> mediaDetails = mediaJson != null
        ? mediaJson.map((i) => Media.fromJson(i)).toList()
        : [];

    var addOnCateringJson = json['addOnCatering'] as List<dynamic>?;
    List<AddOnCatering> addOnCateringDetails = addOnCateringJson != null
        ? addOnCateringJson.map((i) => AddOnCatering.fromJson(i)).toList()
        : [];

    var inventoryItemsJson = json['inventoris_item'] as List<dynamic>?;
    List<InventoryItem> inventoryItemsDetails = inventoryItemsJson != null
        ? inventoryItemsJson.map((i) => InventoryItem.fromJson(i)).toList()
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
        point: json['point'],
        base_delivery: BaseDelivery.fromJson(json['base_delivery']),
        is_fullservice: json['is_fullservice'] ?? 0,
        addOnCatering: addOnCateringDetails,
        catering_name: json['catering_name'] ?? '',
        barista_count: json['barista_count'] ?? '',
        service_count: json['service_count'] ?? '',
        custom_cup: json['custom_cup'] ?? '',
        repayment: json['repayments'] ?? '',
        repayment_date_count: json['count_repay'] ?? '',
        repayment_status: json['status_repay'] ?? '',
      repayment_date_last: json['repay_date_batas'] ?? '',
        inventoryItems: inventoryItemsDetails);
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

class BaseDelivery {
  final int id;
  final String name;
  final dynamic price;
  final String type;
  final String address;
  final String long;
  final String lat;

  BaseDelivery({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.address,
    required this.long,
    required this.lat,
  });

  factory BaseDelivery.fromJson(Map<String, dynamic> json) {
    return BaseDelivery(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      type: json['type'],
      address: json['address'],
      long: json['long'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'address': address,
      'long': long,
      'lat': lat,
    };
  }
}

class BaseDeliveryResponse {
  final String status;
  final BaseDelivery data;

  BaseDeliveryResponse({required this.data, required this.status});

  factory BaseDeliveryResponse.fromJson(Map<String, dynamic> json) {
    return BaseDeliveryResponse(
        data: BaseDelivery.fromJson(json["data"]), status: json['status']);
  }
}
