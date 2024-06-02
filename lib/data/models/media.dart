class Media {
  final String id;
  final String name;
  final String description;
  final String url;

  Media({
    required this.id,
    required this.name,
    required this.description,
    required this.url
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    print('model');
    print(json);
    return Media(
      id: json['id'].toString(),
      name: json['name'],
      description: json['custom_properties']['description'],
      url: json['original_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url' : url
    };
  }
}