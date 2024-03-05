import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:github_client_app/common/global.dart';

class CacheObject {
  CacheObject(this.response) : timeStamp = DateTime.now().microsecond;

  Response response;
  int timeStamp;

  @override
  operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!Global.profile.cache!.enable) {
      return handler.next(options);
    }

    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        delete(options.uri.toString());
      }
      return handler.next(options);
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      var ob = cache[key];

      if (ob != null) {
        if ((DateTime.now().microsecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache!.maxAge) {
          return handler.resolve(ob.response);
        } else {
          cache.remove(key);
        }
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Global.profile.cache!.enable) {
      saveCache(response);
    }

    handler.next(response);
  }

  void delete(String key) {
    cache.remove(key);
  }

  void saveCache(Response response) {
    RequestOptions options = response.requestOptions;

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      if (cache.length == Global.profile.cache!.maxCount) {
        cache.remove(cache.keys.first);
      }

      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }
}
