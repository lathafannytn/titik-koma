class AddOnProduct {
  final String id;
  final String uuid;
  final String name;
  final String optionType;
  final dynamic extraPrice;

  AddOnProduct({
    required this.id,
    required this.name,
    required this.uuid,
    required this.optionType,
    required this.extraPrice,
  });

  factory AddOnProduct.fromJson(Map<String, dynamic> json) {
    return AddOnProduct(
      id: json['id'].toString(),
      name: json['name'],
      uuid: json['uuid'],
      optionType: json['option_type'],
      extraPrice: json['extra_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uuid': uuid,
      'option_type': optionType,
      'extra_price': extraPrice,
    };
  }
}

class AddOnProductResponse {
  final List<AddOnProduct> data;

  AddOnProductResponse({required this.data});

  factory AddOnProductResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<AddOnProduct> products =
        dataList.map((item) => AddOnProduct.fromJson(item)).toList();

    return AddOnProductResponse(data: products);
  }
}
