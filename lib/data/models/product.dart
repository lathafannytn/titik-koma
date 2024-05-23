class ProductDetail {
  final String id;
  final String name;
  final String description;
  final String image;
  final dynamic price;

  ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    print('model');
    print(json);
    return ProductDetail(
      id: json['id'].toString(),
      name: json['name'],
      description: json['desc'],
      price: json['price'],
      image:'https://asset.kompas.com/crops/TX6gacoyGQvvXN6OfM0uHhmwHr0=/74x0:1154x720/750x500/data/photo/2023/12/12/65782d32dfa40.png'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image':image
    };
  }
}

class ProductDetailResponse {
  final ProductDetail? data;

  ProductDetailResponse({this.data});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      data: json['data'] != null ? ProductDetail.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}
