String default_url_image =
    'https://asset.kompas.com/crops/TX6gacoyGQvvXN6OfM0uHhmwHr0=/74x0:1154x720/750x500/data/photo/2023/12/12/65782d32dfa40.png';

class ProductDetail {
  final String id;
  final String name;
  final String description;
  final String image;
  final dynamic price;

  ProductDetail(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    print('model product-detail');
    print(json);
    String imageUrl = default_url_image;
    if (json.containsKey('media') && json['media'].isNotEmpty) {
      print(json['media'][0]['original_url']);
      imageUrl = json['media'][0]['original_url'];
    }
    print(imageUrl);

    return ProductDetail(
        id: json['id'].toString(),
        name: json['name'],
        description: json['desc'],
        price: json['price'],
        image: imageUrl);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image
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

class ProductDetailOrder {
  final String id;
  final String name;
  final String description;
  final String image;
  final dynamic price;
  final dynamic pivot_price;
  final dynamic pivot_quantity;

  ProductDetailOrder(
      {required this.id,
      required this.pivot_price,
      required this.pivot_quantity,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory ProductDetailOrder.fromJson(Map<String, dynamic> json) {
    print('model');
    print(json);
    return ProductDetailOrder(
        id: json['id'].toString(),
        name: json['name'],
        description: json['desc'],
        price: json['price'],
        pivot_price: json['pivot']['unit_price'],
        pivot_quantity: json['pivot']['quantity'],
        image:
            'https://asset.kompas.com/crops/TX6gacoyGQvvXN6OfM0uHhmwHr0=/74x0:1154x720/750x500/data/photo/2023/12/12/65782d32dfa40.png');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image
    };
  }
}
