import 'package:abacus/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You are logged in successfully",
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "$user",
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("Logout"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
