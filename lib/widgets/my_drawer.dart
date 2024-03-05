import 'package:flutter/material.dart';
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
            padding: EdgeInsets.only(top: 80, bottom: 40),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                        child: userModel.isLogin
                            ? GmAvatar(userModel.user!.avatar_url, width: 80)
                            : const Text("not login"))),
                Text(
                  userModel.isLogin ? userModel.user!.login : "登录",
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
            title: Text("主题"),
            onTap: () {
              Navigator.of(context).pushNamed("themes");
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text("语言"),
            onTap: () {
              Navigator.of(context).pushNamed("language");
            },
          ),
          if (userModel.isLogin)
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: const Text("注销"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text("注销"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("取消")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                userModel.user = null;
                              },
                              child: const Text("确认"))
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
