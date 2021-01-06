//TODO: validation   of _range1 and _range2, _range1>=range2>0 and not empty and number

// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MultiplicationScreen extends StatefulWidget {
  final String user;

  MultiplicationScreen({this.user});

  @override
  _MultiplicationScreenState createState() =>
      new _MultiplicationScreenState(user: user);
}

class _MultiplicationScreenState extends State<MultiplicationScreen> {
  TextEditingController _range1, _range2, _numberOfQuestions;
  int tempzero = 0;
  int _isOperation = 0;
  final String user;
  _MultiplicationScreenState({
    @required this.user,
  });

  void initState() {
    super.initState();
    _range1 = TextEditingController();
    _range2 = TextEditingController();
    _numberOfQuestions = TextEditingController();
  }

  void dispose() {
    _range1.dispose();
    _range2.dispose();
    _numberOfQuestions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Multiplication & Division Setting"),
            ),
            body: new Center(
                child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: <Widget>[
                      new Text(
                        'Select the range of the digits',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new SizedBox(
                        height: 16,
                      ),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              width: 120,
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                controller: _range1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    labelText: "Range start",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              color: Colors.white,
                              width: 120,
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                controller: _range2,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    labelText: "Range end",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 250,
                        color: Colors.white,
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CustomRangeTextInputFormatter2(),
                          ],
                          controller: _numberOfQuestions,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              labelText: "Enter Number of Questions",
                              hintText: "should be between 1-100",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _isOperation,
                            onChanged: (int value) {
                              setState(() {
                                _isOperation = value;
                                // print(_isOperation);
                              });
                            },
                          ),
                          new Text(
                            'Multiplication',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                              value: 1,
                              groupValue: _isOperation,
                              onChanged: (int value) {
                                setState(() {
                                  _isOperation = value;
                                  // print(_isOperation);
                                });
                              }),
                          new Text(
                            'Division',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //TODO: Use _range1 and _range2 values
                      new RaisedButton(
                        onPressed: () => {
                          if (int.parse(_range1.text) > int.parse(_range2.text))
                            {
                              Fluttertoast.showToast(
                                  msg: "Start range should be smaller that end",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                            }
                          else
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => (SolveApp(
                                      user: user,
                                      //numdig: _radioValue1,
                                      oper: 1,
                                      noOfTimes: 1,
                                      score: 0,
                                      params: {
                                        'range1': int.parse(_range1.text),
                                        'range2': int.parse(_range2.text),
                                        'numberOfQuestions':
                                            int.parse(_numberOfQuestions.text),
                                        'isOpertaion': _isOperation,
                                      },
                                    )),
                                  )),
                            }
                        },
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
                    ]),
              ),
            ))));
  }
}

class CustomRangeTextInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 100
        ? TextEditingValue().copyWith(text: '100')
        : newValue;
  }
}
