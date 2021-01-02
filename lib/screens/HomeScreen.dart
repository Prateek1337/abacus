// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';

class HomeScreen extends StatefulWidget {
  final String user;

  HomeScreen({this.user});

  @override
  _homescreenState createState() => new _homescreenState(user: user);
}

class _homescreenState extends State<HomeScreen> {
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int tempzero = 0;
  final String user;
  _homescreenState({
    Key key,
    @required this.user,
  });

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
                        onPressed: () => runApp(SolveApp(
                          user: user,
                          numdig: _radioValue1,
                          oper: _radioValue2,
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
