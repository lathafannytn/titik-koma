class Category {
  final int id;
  final String name;
  final String uuid;
  final String desc;

  Category({
    required this.id,
    required this.uuid,
    required this.name,
    required this.desc,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      uuid: json['uuid'],
      desc: json['desc'],
    );
  }
}
// class Category {
//   int id;
//   String name;
//   String uuid;

//   Category({
//     required this.id,
//     required this.uuid,
//     required this.name,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     print('json');
//     print(json['name']);
//     return Category(id: json['id'], name: json['name'], uuid: json['uuid']);
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         'uuid': uuid,
//       };

//   // get uuid => null;

//   // static List<Category> fromJsonList(List<dynamic> jsonList) {
//   //   // print('jsonList');
//   //   // print(jsonList);
//   //   // print()
//   //   print(jsonList.map((json) => Category.fromJson(json)).toList());
//   //   return jsonList.map((json) => Category.fromJson(json)).toList();
//   // }
// }
