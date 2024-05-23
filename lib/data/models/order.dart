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
    var orderJson = json['data'] as Map<String, dynamic>; // Access the data object as a map
    Order order = Order.fromJson(orderJson); // Convert the data object directly to an Order

    return OrderResponse(
      data: [order], // Wrap the Order object in a list
      message: json['msg'],
      status: json['status']
    );
  }
}

// class OrderData {
//   final String id;
//   final String uuid;
//   final dynamic total_price;
//   final dynamic total_quantity;

//   OrderData({
//     required this.id,
//     required this.uuid,
//     required this.total_price,
//     required this.total_quantity,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       id: json['id'].toString(),
//       uuid: json['uuid'],
//       total_price: json['total_price'],
//       total_quantity: json['total_quantity'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'uuid': uuid,
//       'total_price': total_price,
//       'total_quantity': total_quantity,
//     };
//   }
// }

// class OrderDataResponse {
//   final List<OrderData>? data;

//   OrderDataResponse({this.data});

//   factory OrderDataResponse.fromJson(dynamic json) {
//     if (json is List) {
//       List<OrderData> data = json.map((item) => OrderData.fromJson(item)).toList();
//       return OrderDataResponse(data: data);
//     } else if (json is Map<String, dynamic> && json['data'] is List) {
//       List<OrderData> data = (json['data'] as List).map((item) => OrderData.fromJson(item)).toList();
//       return OrderDataResponse(data: data);
//     } else {
//       return OrderDataResponse(data: null);
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'data': data?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

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


