// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:abacus/Variables.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
import 'package:abacus/screens/HomeScreen.dart';

class ScoreScreen extends StatelessWidget {
  int score;
  final String user;

  ScoreScreen({
    Key key,
    @required this.user,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      elevation: 10,
                      color: Colors.blue[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          title: Column(
                            children: [
                              Text(
                                'Your Final Score is ' + score.toString(),
                                style: new TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                "${getEmoji(score)}",
                                style: new TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      onPressed: () => runApp(HomeScreen(user: user)),
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ],
                ))));
  }
  // @override
  // _scoreScreenState createState() => new _scoreScreenState(res,user);
}

getEmoji(int score) {
  double percentage = (score.toDouble() / Variables().maxScore) * 100;
  if (percentage < 20) {
    return Variables().score0;
  } else if (percentage < 40) {
    return Variables().score1;
  } else if (percentage < 60) {
    return Variables().score2;
  } else if (percentage < 80) {
    return Variables().score3;
  } else {
    return Variables().score4;
  }
}

// class _scoreScreenState extends State<ScoreScreen> {
//   int res;
//   final String user;

//   _scoreScreenState({
//     Key key,
//     @required this.res, this.user,
//   }) : super(key: key);

// }
