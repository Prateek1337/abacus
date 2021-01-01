// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

void main() {
  runApp(TheApp());
}

class TheApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyApp(),
      ),
    );
  }
}

// ----------------------------------------------------------------------------------
final FlutterTts flutterTts = FlutterTts();

_speak(String text) async {
  // await flutterTts.setLanguage(language)
  // await flutterTts.setPitch(pitch)

  await flutterTts.speak(text);
  // textEditingController.text = '';
}
// -----------------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  String word;
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: textEditingController,
              // maxLength: 50, //setting maximum length of the textfield
            ),
            //SizedBox is an empty box to add space between two elements
            SizedBox(height: 50),
            RaisedButton(
              child: Text('tap to speak'),
              onPressed: () => _speak(textEditingController.text),
            ),
            SizedBox(height: 50),
            RaisedButton(
              child: Text('Go to Next Page'),
              onPressed: () => runApp(MainPageApp()),
            ),
          ],
        ));
  }
}

//second page starts here----------------------------------------------------------------------------
class MainPageApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MainPageApp> {
  int _radioValue1 = -1;
  int _radioValue2 = -1;

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
        home: new Scaffold(
            appBar: AppBar(
              title: new Text('Abacus'),
              centerTitle: true,
              backgroundColor: Colors.lightBlueAccent,
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
                      new Text(
                        'Select Operator',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            'Addition And \n Subtraction',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(12.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue2,
                            onChanged: _handleRadioValueChange2,
                          ),
                          new Text(
                            'Multiplication',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          // new Radio(
                          //   value: 2,
                          //   groupValue: _radioValue2,
                          //   onChanged: _handleRadioValueChange2,
                          // ),
                          // new Padding(
                          //   padding: new EdgeInsets.all(12.0),
                          // ),
                          // new Text(
                          //   'Division',
                          //   style: new TextStyle(fontSize: 16.0),
                          // ),
                        ],
                      ),
                      // new Divider(
                      //   height: 5.0,
                      //   color: Colors.black,
                      // ),
                      // new Padding(
                      //   padding: new EdgeInsets.all(12.0),
                      // ),
                      new RaisedButton(
                        onPressed: () => runApp(
                            SolveApp(numdig: _radioValue1, oper: _radioValue2)),
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

// --------------------------------------------------------------------------------------------------------------------
// third page
var randmap = {'1': 9, '2': 90, '3': 900, '4': 9000};
var addmap = {'1': 0, '2': 10, '3': 100, '4': 1000};
var rng = new Random();

List multiplyString(String digcount) {
  int num1 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  int num2 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  int res = num1 * num2;
  return [res.toString(), num1.toString() + '*' + num2.toString()];
}

List addString(String digcount) {
  // int num1 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  // int num2 = rng.nextInt(randmap[digcount]) + addmap[digcount];

  int res = rng.nextInt(randmap[digcount]) + addmap[digcount];
  String question = res.toString();

  for (int i = 0; i < 4; i++) {
    int _num = rng.nextInt(randmap[digcount]) + addmap[digcount];
    int sign = rng.nextInt(2);
    // 0 for sub and 1 for add
    if (sign == 0 && res - _num >= 0) {
      res = res - _num;
      question = question + '-' + _num.toString();
    } else {
      res = res + _num;
      question = question + '+' + _num.toString();
    }
  }
  return [res.toString(), question];
}

// List divideString(String digcount) {
//   int num1 = rng.nextInt(randmap[digcount]) + addmap[digcount];
//   int num2 = rng.nextInt(randmap[digcount]) + addmap[digcount];
//   Double res = num1.toDouble() / num2.toDouble();
//   return [res.toString(), num1.toString() + num2.toString()];
// }

class SolveApp extends StatelessWidget {
  int numdig, oper;
  SolveApp({Key key, @required this.numdig, this.oper}) : super(key: key);
  String sumtext = '';

  //function to do generate the sum
  String callOper() {
    List finalres;
    if (oper == 0) {
      finalres = addString(numdig.toString());
    } else {
      finalres = multiplyString(numdig.toString());
    }
    String result = finalres[0];
    String question_tts = finalres[1];
    int resInt = int.parse(result);
    return question_tts + ' : result is' + result;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              title: new Text('Abacus'),
              centerTitle: true,
              backgroundColor: Colors.lightBlueAccent,
            ),
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      callOper(),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ))));
  }
}
