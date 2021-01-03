// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';
import 'package:flutter/services.dart';

class AdditionScreen extends StatefulWidget {
  final String user;

  AdditionScreen({this.user});

  @override
  _AdditionScreenState createState() => new _AdditionScreenState(user: user);
}

class _AdditionScreenState extends State<AdditionScreen> {
  TextEditingController _controller;
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int tempzero = 0;
  final String user;

  _AdditionScreenState({
    Key key,
    @required this.user,
  });
  void initState() {
    super.initState();
    _handleRadioValueChange1(1);

    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
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
              title: Text("Addition & Subraction Setting"),
            ),
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Select Number of digits:',
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
                      new SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 250,
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CustomRangeTextInputFormatter(),
                          ],
                          controller: _controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              labelText: "Enter number of values",
                              hintText: "Range 1-20",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      new SizedBox(
                        height: 16,
                      ),
                      // new Row(
                      //   children: <Widget>[
                      //     new TextField(
                      //       decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           hintText: 'Enter number of values'),
                      //     ),
                      //   ],
                      // ),

                      //TODO: Use controller to take input value and pass to SolveApp

                      new RaisedButton(
                        onPressed: () => runApp(SolveApp(
                          user: user,
                          numdig: _radioValue1,
                          oper: 0,
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

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 20
        ? TextEditingValue().copyWith(text: '20')
        : newValue;
  }
}
