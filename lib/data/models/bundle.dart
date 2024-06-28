import 'package:intl/intl.dart';
import 'package:tikom/class/card/product/product.dart';
import 'package:tikom/data/models/drinks.dart';
import 'package:tikom/data/models/product.dart';

class Bundle {
  final String id;
  final dynamic name;
  final dynamic desc;
  final dynamic normal_price;
  final dynamic bundle_price;
  final dynamic max_buy;
  final List<Drinks>? drinks;

  Bundle(
      {required this.id,
      required this.name,
      required this.desc,
      required this.bundle_price,
      required this.normal_price,
      required this.max_buy,
      this.drinks});

  factory Bundle.fromJson(Map<String, dynamic> json) {
    List<Drinks> drinkDetails = [];
    if (json.containsKey('products')) {
      var drinkJson = json['products'] as List;
      print('from model');
      print(drinkJson);
      print('drink details');
      drinkDetails = drinkJson.map((item) => Drinks.fromJson(item)).toList();
    }
    print(drinkDetails);

    var desc_full = json['desc'].split('//');

    return Bundle(
        id: json['id'].toString(),
        name: json['name'],
        desc: desc_full[0],
        bundle_price: json['bundle_price'],
        normal_price: json['normal_price'],
        max_buy: int.parse(desc_full[1]),
        drinks: drinkDetails);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'bundle_price': bundle_price,
      'normal_price': normal_price,
      'max_buy': max_buy,
      'drinks': drinks,
    };
  }
}

class BundleResponse {
  final List<Bundle> data;

  BundleResponse({required this.data});

  factory BundleResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Bundle> data = dataList.map((item) => Bundle.fromJson(item)).toList();

    return BundleResponse(data: data);
  }
}
