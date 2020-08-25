import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/utils/auth.dart';

import 'package:flutter_api_rest/models/user.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {

  User user;
  @override
  void afterFirstLayout(BuildContext context) {
    this._init();
  }

  _init() async {
    this.user = await MyApi.instance.getUserInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget> [
                this.user == null
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator()
                )
                :Column(
                  children: <Widget> [
                    Text(this.user.userName),
                    Text(this.user.email),
                    Text(this.user.createdAt.toLocal().toString()),
                  ]
                ),
                FlatButton(
                    child: Text("Log Out"),
                    onPressed: () => Auth.instance.logout(context),
                  )
              ],
            )
          )
        ),
      )
    );
  }
}