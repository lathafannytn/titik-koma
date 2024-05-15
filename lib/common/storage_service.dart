import 'package:get_storage/get_storage.dart';

class StorageService {
  static final box = GetStorage();

  static void saveData(String key, dynamic value) {
    box.write(key, value);
  }

  static dynamic getData(String key) {
    return box.read(key);
  }

  static void removeData(String key) {
    box.remove(key);
  }
}
