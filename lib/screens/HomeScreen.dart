import 'package:abacus/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  final String user;

  HomeScreen({this.user});

  @override
  _homescreenState createState() => new _homescreenState();
}

class _homescreenState extends State<HomeScreen> {
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
        home: Scaffold(
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

final FlutterTts flutterTts = FlutterTts();

_speak(String text) async {
  // await flutterTts.setLanguage(language)
  // await flutterTts.setPitch(pitch)

  await flutterTts.speak(text);
  // textEditingController.text = '';
}

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
    _speak(result);
    return question_tts + ' : result is' + result;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      callOper(),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Container(
                      width: 120,
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
                    )
                  ],
                ))));
  }
}

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     home: Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "You are logged in successfully",
//               style: TextStyle(color: Colors.lightBlue, fontSize: 32),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Text(
//               "$user",
//               style: TextStyle(color: Colors.grey),
//             ),
//             Container(
//               width: double.infinity,
//               child: FlatButton(
//                 child: Text("Logout"),
//                 textColor: Colors.white,
//                 padding: EdgeInsets.all(16),
//                 onPressed: () async {
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   prefs.clear();
//                   FirebaseAuth.instance.signOut();
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()));
//                 },
//                 color: Colors.blue,
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
