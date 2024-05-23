class Order {
  final String id;
  final String uuid;
  final dynamic total_price;
  final dynamic total_quantity;

  Order({
    required this.id,
    required this.uuid,
    required this.total_price,
    required this.total_quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      uuid: json['uuid'],
      total_price: json['total_price'],
      total_quantity: json['total_quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'total_price': total_price,
      'total_quantity': total_quantity,
    };
  }
}

class OrderResponse {
  final String status;
  final String message;
  final List<Order> data;

  OrderResponse({required this.data,required this.status, required this.message});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Order> products =
        dataList.map((item) => Order.fromJson(item)).toList();
      

    return OrderResponse(
      data: products,
      message: json['msg'],
      status: json['status']
    );
  }
}
