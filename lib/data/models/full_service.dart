class FullService {
  final String id;
  final String type;
  final String description;
  final dynamic price;

  FullService({
    required this.id,
    required this.type,
    required this.description,
    required this.price,
  });

  factory FullService.fromJson(Map<String, dynamic> json) {
    print('model');
    print(json);
    return FullService(
      id: json['id'].toString(),
      type: json['type'],
      description: json['desc'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type':type,
      'description': description,
      'price': price,
    };
  }
}

class FullServiceResponse {
  final List<FullService> data;

  FullServiceResponse({required this.data});

  factory FullServiceResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<FullService> caterings =
        dataList.map((item) => FullService.fromJson(item)).toList();
    return FullServiceResponse(
      data: caterings
    );
  }

 
}
