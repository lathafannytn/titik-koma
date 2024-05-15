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

  Drinks( {
    required this.id,
    required this.uuid,
    required this.name,
    required this.desc,
    required this.price, 
    required this.imgUrl, 
    required this.stock, 
    required this.categoryId, 
    required this.categoryName
  });

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      id: json['id'],
      uuid: json['uuid'],
      categoryId:json['product_category_id'], 
      name: json['name'],
      desc: json['desc'],
      price: json['price'], 
      stock: json['stok'], 
      imgUrl: 'https://rm.id/files/konten/berita/prabowo-kenyang-sekolah-di-ln-ini-8-prestasinya-sebagai-menhan_194542.jpeg',
      categoryName: json['category']['name'],
      
    );
  }
}
