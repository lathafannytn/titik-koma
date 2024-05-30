// class Drinks {
//   String name;
//   num price;
//   String desc;
//   String imgUrl;
//   int stock;
//   int categoryId;

//   Drinks({
//     required this.name,
//     required this.price,
//     required this.desc,
//     required this.imgUrl,
//     required this.stock,
//     required this.categoryId,
//   });

//   factory Drinks.fromJson(Map<String, dynamic> json) {
//     return Drinks(
//       name: json['name'],
//       price: json['price'],
//       desc: json['desc'] ?? 'No description',
//       imgUrl: 'https://example.com/images/${json['name']}',
//       stock: json['stock'],
//       categoryId: json['category_id'],
//     );
//   }

//   static List<Drinks> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((json) => Drinks.fromJson(json)).toList();
//   }
// }

import 'dart:core';

String default_url_image =
    'https://asset.kompas.com/crops/TX6gacoyGQvvXN6OfM0uHhmwHr0=/74x0:1154x720/750x500/data/photo/2023/12/12/65782d32dfa40.png';

class Drinks {
  final dynamic id;
  final dynamic categoryId;
  final dynamic stock;
  final dynamic name;
  final dynamic uuid;
  final dynamic price;
  final dynamic desc;
  final dynamic imgUrl;
  final dynamic categoryName;

  Drinks(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.desc,
      required this.price,
      required this.imgUrl,
      required this.stock,
      required this.categoryId,
      required this.categoryName});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    String imageUrl = default_url_image;
    if (json.containsKey('media') && json['media'].isNotEmpty) {
      print(json['media'][0]['original_url']);
      imageUrl = json['media'][0]['original_url'];
    }
    return Drinks(
      id: json['id'],
      uuid: json['uuid'],
      categoryId: json['product_category_id'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      stock: json['stok'],
      imgUrl: imageUrl,
      categoryName: json['category']['name'],
    );
  }
}
