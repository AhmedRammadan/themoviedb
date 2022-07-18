import 'package:flutter_cache/flutter_cache.dart' as cache;

class MyCache {
  static load(key) async {
    try {
      var cacheRes = await cache.load(key);
      return cacheRes;
    } catch (e) {
      return;
    }
  }

  static destroy(key) async {
    try {
      cache.destroy(key);
      return;
    } catch (e) {
      return;
    }
  }

  static remember(key, response) async {
    try {
      await cache.remember(key, response, 120);
      var _cache = await load(key);
      return _cache;
    } catch (e) {
      return;
    }
  }
}
