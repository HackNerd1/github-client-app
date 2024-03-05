import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/models/index.dart';

class Git {
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;
  late Options _options;

  static Dio dio =
      Dio(BaseOptions(baseUrl: 'https://api.github.com/', headers: {
    HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
        "application/vnd.github.symmetra-preview+json"
  }));

  static void init() {
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    if (Global.isRelease) {
      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      // ignore: deprecated_member_use
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
      };
    }
  }

  // 登录
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic ${base64.encode(utf8.encode("$login:$pwd"))}';

    var response = await dio.get("/user",
        options: _options.copyWith(
            headers: {HttpHeaders.authorizationHeader: basic},
            extra: {"noCache": true}));

    dio.options.headers[HttpHeaders.authorizationHeader] = basic;

    Global.netCache.cache.clear();
    Global.profile.token = basic;

    return User.fromJson(response.data);
  }

  // 获取用户项目列表
  Future<List<Repo>> getRepo(
      {Map<String, dynamic>? queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra!.addAll({"refresh": true, "list": true});
    }

    var response = await dio.get<List>("user/repos",
        queryParameters: queryParameters, options: _options);
    return response.data!.map((value) => Repo.fromJson(value)).toList();
  }
}
