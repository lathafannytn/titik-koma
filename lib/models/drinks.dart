class Drinks {
  String name;
  num price;
  String desc;
  String imgUrl;
  int stock;
  int categoryId;

  Drinks({
    required this.name,
    required this.price,
    required this.desc,
    required this.imgUrl,
    required this.stock,
    required this.categoryId,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      name: json['name'],
      price: json['price'],
      desc: json['desc'] ?? 'No description',
      imgUrl: 'https://example.com/images/${json['name']}',
      stock: json['stock'],
      categoryId: json['category_id'],
    );
  }

  static List<Drinks> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Drinks.fromJson(json)).toList();
  }
}