import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tikom/data/models/place/place_model.dart';

class Repo {
  Repo._();
  static Future<PredictionModel?> placeAutoComplete(
      {required String placeInput}) async {
    try {
      Map<String, dynamic> querys = {
        'input': placeInput,
        'key': 'AIzaSyASGjI8zNA5NtrhDIc17Eur2HLP3RHi5Ns'
      };
      final url = Uri.https(
          "maps.googleapis.com", "maps/api/place/autocomplete/json", querys);
      final response = await http.get(url);
      print('from respon');
      print(placeInput);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return PredictionModel.fromJson(jsonDecode(response.body));
      } else {
        response.body;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
