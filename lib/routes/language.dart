import 'package:flutter/material.dart';
import 'package:github_client_app/l10n/gm_localization.dart';
import 'package:github_client_app/states/locale_model.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {
  const LanguageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;

    var localeModel = Provider.of<LocalModel>(context);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing: localeModel.locale == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: () {
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Gmlocalizations.of(context).language),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          _buildLanguageItem("简体中文", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem("跟随系统", null),
        ],
      ),
    );
  }
}
