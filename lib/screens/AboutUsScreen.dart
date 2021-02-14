import 'package:flutter/cupertino.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final String user;
  AboutUsScreen({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Add your Global Settings
    return new Scaffold(
      appBar: AppBar(title: Text("About Us")),
      drawer: AppDrawer(user: user),
      body: Text("ABout Us Page"),
    );
  }
}
