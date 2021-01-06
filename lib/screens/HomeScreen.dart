// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  final String user;

  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => new _HomeScreenState(user: user);
}

class _HomeScreenState extends State<HomeScreen> {
  int tempzero = 0;
  final String user;
  _HomeScreenState({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        body: new Container(
          padding: EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Addition and Subtraction"),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdditionScreen(
                                user: user,
                              )),
                    ),
                    // runApp(AdditionScreen(
                    //   user: user,
                    // ))
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Card(
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Multiplication and Division"),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiplicationScreen(
                                user: user,
                              )),
                    ),
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 120,
                child: Card(
                  elevation: 10,
                  child: FlatButton(
                    child: Text("Logout"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    color: Colors.blue,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
