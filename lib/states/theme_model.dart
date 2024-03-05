import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/common/profile_change_notifier.dart';

class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get tehme =>
      Global.themes.firstWhere((element) => element.value == profile.theme,
          orElse: () => Colors.blue);

  set theme(ColorSwatch color) {
    if (color != tehme) {
      profile.theme = color[500]!.value;
      notifyListeners();
    }
  }
}
