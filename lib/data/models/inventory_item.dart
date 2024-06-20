class InventoryItem {
  final String id;
  final String  name;
  final dynamic desc;

  InventoryItem({
    required this.id,
    required this.name,
    required this.desc,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'].toString(),
      name: json['name'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
    };
  }
}