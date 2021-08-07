import 'package:get_storage/get_storage.dart';

class Cache {
  static final cache = GetStorage();

  static void putCache(String response, String time) async {
    if (cache.hasData('trending') || cache.hasData('time')) {
      await cache.remove('trending');
      await cache.remove('time');
    }
    await cache.write('trending', response);
    await cache.write('time', time);
  }

  static bool checkCache(String key) {
    return cache.hasData(key);
  }

  static String readCache(String key) {
    return cache.read(key);
  }

  static void deleteCache(String key) async {
    await cache.remove(key);
  }
}
