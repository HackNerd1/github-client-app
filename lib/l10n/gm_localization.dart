import 'package:flutter/material.dart';
import 'package:github_client_app/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class Gmlocalizations {
  static Future<Gmlocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    return initializeMessages(localName).then((b) {
      Intl.defaultLocale = localName;
      return Gmlocalizations();
    });
  }

  static Gmlocalizations of(BuildContext context) {
    return Localizations.of(context, Gmlocalizations);
  }

  String get title {
    return Intl.message('Github App',
        name: 'title', desc: 'Title for the demo application');
  }

  String get language {
    return Intl.message('Language', name: 'language');
  }

  String get theme {
    return Intl.message('Theme', name: 'theme');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get username {
    return Intl.message('Username', name: 'username');
  }

  String get usernamePlaceholder {
    return Intl.message('please input username', name: 'usernamePlaceholder');
  }

  String get passowrd {
    return Intl.message('Passowrd', name: 'passowrd');
  }

  String get passwordPlaceholder {
    return Intl.message('please input password', name: 'passwordPlaceholder');
  }

  String get logout {
    return Intl.message('Logout', name: 'logout');
  }

  String get cancel {
    return Intl.message('Cancel', name: 'cancel');
  }

  String get confrim {
    return Intl.message('Confrim', name: 'confrim');
  }

  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});
}

class GmlocalizationsDelegate extends LocalizationsDelegate<Gmlocalizations> {
  //是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Gmlocalizations> load(Locale locale) {
    return Gmlocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(covariant LocalizationsDelegate<Gmlocalizations> old) {
    return false;
  }
}
