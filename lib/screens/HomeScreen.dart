// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
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
              Card(
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
                  },
                ),
              ),
              Card(
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
              )
            ],
          ),
        ),
      ),
    );
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
