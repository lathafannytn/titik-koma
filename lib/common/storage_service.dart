// import 'package:get_storage/get_storage.dart';

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

  static Future<String?> getData(String key) async {
    return _box.read(key);
  }

  static Future<void> removeData(String key) async {
    await _box.remove(key);
  }
}
