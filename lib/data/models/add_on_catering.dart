class AddOnCatering {
  final String id;
  final String uuid;
  final String name;
  final dynamic extraPrice;

  AddOnCatering({
    required this.id,
    required this.name,
    required this.uuid,
    required this.extraPrice,
  });

  factory AddOnCatering.fromJson(Map<String, dynamic> json) {
    return AddOnCatering(
      id: json['id'].toString(),
      name: json['name'],
      uuid: json['uuid'],
      extraPrice: json['extra_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uuid': uuid,
      'extra_price': extraPrice,
    };
  }
}

class AddOnCateringResponse {
  final List<AddOnCatering> data;

  AddOnCateringResponse({required this.data});

  factory AddOnCateringResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<AddOnCatering> Caterings =
        dataList.map((item) => AddOnCatering.fromJson(item)).toList();

    return AddOnCateringResponse(data: Caterings);
  }
}
