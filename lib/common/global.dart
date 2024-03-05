import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/common/cache_object.dart';
import 'package:github_client_app/common/git.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  // 全局共享数据
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static final List<MaterialColor> themes = <MaterialColor>[
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.red
  ];

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();

    var _profile = _prefs.getString("profile");

    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile()..theme = 0;
    }

    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Git.init();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toString()));
}
