/*
 * @Descripttion: 
 * @version: 0.0.1
 * @Author: Hansel
 * @Date: 2024-03-05 19:46:00
 * @LastEditors: Please set LastEditors
 * @LastEditTime: 2024-03-05 19:46:09
 */
import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/l10n/gm_localization.dart';
import 'package:github_client_app/states/theme_model.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  const ThemeChangeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(Gmlocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes
            .map((theme) => GestureDetector(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Container(
                      color: theme,
                      height: 40,
                    ),
                  ),
                  onTap: () {
                    print("theme change ${theme}");
                    Provider.of<ThemeModel>(context, listen: false).theme =
                        theme;
                  },
                ))
            .toList(),
      ),
    );
  }
}
