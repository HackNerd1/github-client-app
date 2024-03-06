/*
 * @Descripttion: 
 * @version: 0.0.1
 * @Author: Hansel
 * @Date: 2024-03-05 19:45:09
 * @LastEditors: Please set LastEditors
 * @LastEditTime: 2024-03-05 19:45:29
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/git.dart';
import 'package:github_client_app/common/show_loding.dart';
import 'package:github_client_app/l10n/gm_localization.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/states/user_model.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  bool showPwd = false;

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _nameAutoFocus = true;

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Gmlocalizations.of(context).login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: Gmlocalizations.of(context).username,
                    hintText: Gmlocalizations.of(context).username,
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : Gmlocalizations.of(context).usernamePlaceholder;
                },
              ),
              TextFormField(
                controller: _passwordController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: Gmlocalizations.of(context).passowrd,
                    hintText: Gmlocalizations.of(context).passowrd,
                    prefixIcon: IconButton(
                      icon:
                          Icon(showPwd ? Icons.visibility_off : Icons.password),
                      onPressed: () {
                        setState(() {
                          showPwd = !showPwd;
                        });
                      },
                    )),
                obscureText: !showPwd,
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : Gmlocalizations.of(context).passwordPlaceholder;
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(height: 55.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _onLogin();
                          },
                          child: Text(Gmlocalizations.of(context).login))))
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      User? user;

      showLoading(context);

      try {
        user = await Git(context)
            .login(_usernameController.text, _passwordController.text);

        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioException catch (e) {
        print("==================== ${e}");
        if (e.response?.statusCode == 401) {
          print("错误的用户名或密码");
        } else {
          print("================= ${e.toString()}");
        }
      } finally {
        Navigator.of(context).pop();
      }

      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
