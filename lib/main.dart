import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/routes/home.dart';
import 'package:github_client_app/routes/language.dart';
import 'package:github_client_app/routes/login.dart';
import 'package:github_client_app/routes/theme_change.dart';
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
          builder: (context, themeModel, localModel, child) {
            return MaterialApp(
              // theme: ThemeData(primarySwatch: themeModel.tehme),
              home: const HomeRoute(),
              locale: localModel.getLocale(),
              onGenerateTitle: (context) {
                return 'title';
              },
              supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
              localeResolutionCallback: (locale, supportedLocales) {
                if (localModel.getLocale() != null) {
                  return localModel.getLocale();
                } else {
                  // ignore: no_leading_underscores_for_local_identifiers
                  Locale _locale;
                  if (supportedLocales.contains(locale)) {
                    _locale = locale!;
                  } else {
                    _locale = const Locale('en', 'US');
                  }
                  return _locale;
                }
              },
              routes: {
                'login': (context) => const LoginRoute(),
                'themes': (context) => const ThemeChangeRoute(),
                'language': (context) => const LanguageRoute()
              },
            );
          },
        ));
  }
}
