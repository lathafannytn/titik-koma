import 'package:tikom/data/models/add_on_product.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/product.dart';

class OrderProduct {
  final String id;
  final String uuid;
  final dynamic total_price;
  final dynamic total_quantity;
  final ProductDetail product_detail;
  // final AddOnProduct add_on_product;

  OrderProduct({
    required this.id,
    required this.uuid,
    required this.total_price,
    required this.total_quantity,
    required this.product_detail,
    // required this.add_on_product
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    print('model order product');
    var dataList = json['product'];
    print(dataList);

    return OrderProduct(
      id: json['id'].toString(),
      uuid: json['uuid'],
      total_price: json['quantitiy'],
      total_quantity: json['unit_price'],
      product_detail:ProductDetail.fromJson(json['product']) ,
      // add_on_product: json['add_on_product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'total_price': total_price,
      'total_quantity': total_quantity,
      'product_detail': product_detail,
      // 'add_on_product': add_on_product,
    };
  }
}

class OrderProductResponse {
  final List<OrderProduct> order;

  OrderProductResponse({required this.order});

  factory OrderProductResponse.fromJson(Map<String, dynamic> json) {
    print('--model---');
    print(json['data']);
    var dataList = json['data'] as List;
    List<OrderProduct> order =
        dataList.map((item) => OrderProduct.fromJson(item)).toList();

    return OrderProductResponse(
      order: order,
    );
  }
}
