import 'package:get_storage/get_storage.dart';

// class StorageService {
//   static final box = GetStorage();

//   static void saveData(String key, dynamic value) {
//     box.write(key, value);
//   }

//   static dynamic getData(String key) {
//     return box.read(key);
//   }

//   static void removeData(String key) {
//     box.remove(key);
//   }
// }

import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _box = GetStorage();

  static Future<void> saveData(String key, String value) async {
    await _box.write(key, value);
  }
    static Future<void> saveDataInit(String key, int value) async {
    await _box.write(key, value);
  }

  static Future<String?> getData(String key) async {
    var data = _box.read(key);
    return data;
  }
    static dynamic getDataInt(String key)  {
    var data = _box.read(key);
      if (data != null && data is String) {
      return int.tryParse(data);
    }
    return null;
  }

  static Future<void> removeData(String key) async {
    await _box.remove(key);
  }

  static dynamic getToken(String key) {
    return _box.read(key);
  }
}
