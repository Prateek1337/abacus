// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abacus/Variables.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';
import 'SolveScreen.dart';

class IsAllowedScreen extends StatelessWidget {
  final String user;

  IsAllowedScreen({this.user});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc("phoneNumberAccess").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (data[user] != null && data[user] == true) {
            return HomeScreen(user: user);
          }
          //users.doc("phoneNumberAcccess").set({'$user': false});
          addUser(user);
          return Center(
            child: Wrap(children: <Widget>[
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
                          "The Phone Number $user is not allowed.\nPlease get your phone number validated. ",
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
            ]),
          );

          //   return Text(
          //       "The Phone Number $user is not allowed or invalid. Please get your phone number validated ");
        }

        return Center(
          child: Wrap(children: <Widget>[
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
                        "LOADING...",
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
          ]),
        );
      },
    );
  }
}

addUser(String phNo) {
  FirebaseFirestore.instance.collection("users").doc('phoneNumberAccess').set({
    '$phNo': false,
  }, SetOptions(merge: true));
}

// void LogPrint(Object object) async {
//   int defaultPrintLength = 1020;
//   if (object == null || object.toString().length <= defaultPrintLength) {
//     print(object);
//   } else {
//     String log = object.toString();
//     int start = 0;
//     int endIndex = defaultPrintLength;
//     int logLength = log.length;
//     int tmpLogLength = log.length;
//     while (endIndex < logLength) {
//       print(log.substring(start, endIndex));
//       endIndex += defaultPrintLength;
//       start += defaultPrintLength;
//       tmpLogLength -= defaultPrintLength;
//     }
//     if (tmpLogLength > 0) {
//       print(log.substring(start, logLength));
//     }
//   }
// }

Future _stop() async {
  if (flutterTts != null) await flutterTts.stop();
}

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

  void initState() {
    super.initState();
    _stop();
  }

  @override
  Widget build(BuildContext context) {
    // Future _speak(String text) async {
    //   final FlutterTts flutterTts = FlutterTts();
    //   // print(await flutterTts.getVoices);
    //   LogPrint(await flutterTts.getVoices);
    //   await flutterTts.setLanguage('en-US');
    //   await flutterTts.setVoice('hi-in-x-hia-local');
    //   await flutterTts.speak(text);
    // }

    // _speak('hey there, how are you guys, welcome to our app');
    // _speak('1234567 plus 3300 minus 21 multiplied by 5 divided by 12312');

    //  print(FlutterTts().getVoices);
    // print('\n\n\n\n\n\n\n\n\n\n\n hello\n\n\n\n\n\n\n\n\n');

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  title: Text("Add & Subtract"),
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
                  title: Text("Multiply & Divide"),
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
