// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';

class MultiplicationScreen extends StatefulWidget {
  final String user;

  MultiplicationScreen({this.user});

  @override
  _MultiplicationScreenState createState() =>
      new _MultiplicationScreenState(user: user);
}

class _MultiplicationScreenState extends State<MultiplicationScreen> {
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int tempzero = 0;
  final String user;
  _MultiplicationScreenState({
    Key key,
    @required this.user,
  });

  void initState() {
    super.initState();
    _handleRadioValueChange1(1);
    _handleRadioValueChange2(1);
  }

  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Multiplication & Division Setting"),
            ),
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Select Number of digits for first value:',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      // new Padding(
                      //   padding: new EdgeInsets.all(8.0),
                      // ),
                      // // new Divider(height: 5.0, color: Colors.black),
                      // new Padding(
                      //   padding: new EdgeInsets.all(8.0),
                      // ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            '1',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 2,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            '2',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 3,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            '3',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 4,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            '4',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),

                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      // new Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      new Text(
                        'Select Number of digits for second value:',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            '1',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 2,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            '2',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 3,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            '3',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 4,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            '4',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      new RaisedButton(
                        onPressed: () => runApp(SolveApp(
                          user: user,
                          numdig: _radioValue1,
                          oper: 1,
                          noOfTimes: 1,
                          score: 0,
                        )),
                        child: new Text(
                          'Start',
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                      ),
                      // ])
                    ]))));
  }
}
