import 'package:flutter/material.dart';
import 'package:github_client_app/common/git.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/states/user_model.dart';
import 'package:github_client_app/widgets/my_drawer.dart';
import 'package:github_client_app/widgets/repo_item.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  var _items = <Repo>[Repo()..name = loadingTag];

  bool hasMore = true; //是否还有数据

  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github 客户端"),
      ),
      drawer: const MyDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);

    if (!userModel.isLogin) {
      return Center(
        child: ElevatedButton(
          child: const Text("login"),
          onPressed: () {},
        ),
      );
    } else {
      return ListView.separated(
          itemBuilder: (context, index) {
            if (_items[index].name == loadingTag) {
              if (hasMore) {
                _fetchData();

                // 显示刷新按钮
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      )),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("没有更多了"),
                );
              }
            }
            return const RepoItem();
          },
          separatorBuilder: (context, index) => const Divider(height: .0),
          itemCount: _items.length);
    }
  }

  void _fetchData() async {
    var data = await Git(context).getRepo(
      queryParameters: {
        'page': page,
        'page_size': 20,
      },
    );

    hasMore = data.isNotEmpty && data.length % 20 == 0;

    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }
}
