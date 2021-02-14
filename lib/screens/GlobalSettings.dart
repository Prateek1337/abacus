import 'package:flutter/cupertino.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:flutter/material.dart';

class GlobalSettings extends StatelessWidget {
  final String user;
  GlobalSettings({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Add your Global Settings
    return new Scaffold(
      appBar: AppBar(title: Text("Settings")),
      drawer: AppDrawer(user: user),
      body: Text("Global Settings Page"),
    );
  }
}
