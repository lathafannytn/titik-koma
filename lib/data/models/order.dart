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
  final List<Order>? data;

  OrderResponse({this.data, required this.status, required this.message});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    List<Order>? orders;
    if (json.containsKey('data')) {
      var orderJson = json['data'] as Map<String, dynamic>;
      Order order = Order.fromJson(orderJson);
      orders = [order];
    }

    return OrderResponse(
        data: orders, message: json['msg'], status: json['status']);
  }
}

class OrderData {
  final String id;
  final String uuid;
  final dynamic total_price;
  final dynamic total_quantity;

  OrderData({
    required this.id,
    required this.uuid,
    required this.total_price,
    required this.total_quantity,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
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

class OrderDataResponse {
  final List<OrderData> data;

  OrderDataResponse({required this.data});

  factory OrderDataResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<OrderData> products =
        dataList.map((item) => OrderData.fromJson(item)).toList();

    return OrderDataResponse(data: products);
  }
}

class PotonganData {
  final String id;
  final dynamic total_price;
  final dynamic total_quantity;

  PotonganData({
    required this.id,
    required this.total_price,
    required this.total_quantity,
  });

  factory PotonganData.fromJson(Map<String, dynamic> json) {
    return PotonganData(
      id: json['id'].toString(),
      total_price: json['price'],
      total_quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_price': total_price,
      'total_quantity': total_quantity,
    };
  }
}

class PotonganDataResponse {
  final String status;
  final PotonganData data;

  PotonganDataResponse({required this.data, required this.status});

  factory PotonganDataResponse.fromJson(Map<String, dynamic> json) {
    // var dataList = json['data'] as List;
    // List<PotonganData> products =
    //     dataList.map((item) => PotonganData.fromJson(item)).toList();

    return PotonganDataResponse(
        data: PotonganData.fromJson(json["data"]), status: json['status']);
  }
}
