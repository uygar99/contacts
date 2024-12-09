import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static const String apikey = '84ba3248-0b14-4f37-87cd-7c92b68ba569';
}

/*class Storage {
  Storage._();
  factory Storage() => instance;
  static final Storage instance = Storage._();

  Future<void> setKey(String key) async {
    await GetStorage().write(StorageKeys.apikey, key);
  }

  String? getKey() {
    return GetStorage().read<String>(StorageKeys.apikey);
  }
}*/
