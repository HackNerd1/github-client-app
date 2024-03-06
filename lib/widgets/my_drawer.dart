import 'package:flutter/material.dart';
import 'package:github_client_app/l10n/gm_localization.dart';
import 'package:github_client_app/states/user_model.dart';
import 'package:github_client_app/widgets/gm_avatar.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            children: [_buildHeader(), Expanded(child: _buildMenus())],
          )),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(top: 80, bottom: 40),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                        child: userModel.isLogin
                            ? GmAvatar(userModel.user!.avatar_url, width: 80)
                            : const Text("not login"))),
                Text(
                  userModel.isLogin
                      ? userModel.user!.login
                      : Gmlocalizations.of(context).login,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!userModel.isLogin) {
              Navigator.of(context).pushNamed("login");
            }
          },
        );
      },
    );
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(builder: (context, userModel, child) {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(Gmlocalizations.of(context).theme),
            onTap: () {
              Navigator.of(context).pushNamed("themes");
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(Gmlocalizations.of(context).language),
            onTap: () {
              Navigator.of(context).pushNamed("language");
            },
          ),
          if (userModel.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(Gmlocalizations.of(context).logout),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(Gmlocalizations.of(context).logout),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(Gmlocalizations.of(context).cancel)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                userModel.user = null;
                              },
                              child: Text(Gmlocalizations.of(context).confrim))
                        ],
                      );
                    });
              },
            )
        ],
      );
    });
  }
}
