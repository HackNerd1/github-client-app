import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/states/locale_model.dart';
import 'package:github_client_app/states/theme_model.dart';
import 'package:github_client_app/states/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeModel()),
          ChangeNotifierProvider(create: (_) => LocalModel()),
          ChangeNotifierProvider(create: (_) => UserModel()),
        ],
        child: Consumer2<ThemeModel, LocalModel>(
          builder: (context, value, value2, child) {
            return MaterialApp();
          },
        ));
  }
}
