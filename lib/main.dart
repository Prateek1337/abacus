import 'package:abacus/screens/LoginScreen.dart';
import 'package:abacus/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool isLoggedIn = prefs.getBool(Variables().isLoggedIn) ?? false;
  // if (isLoggedIn) {
  //   await Firebase.initializeApp();
  //   String phone = prefs.getString(Variables().phoneNumber);
  //   runApp(MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: IsAllowedScreen(
  //       user: phone,
  //     ),
  //   ));
  // } else {
  //   runApp(MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: MyApp(),
  //   ));
  // }
  // /*runApp(MaterialApp(
  //   home: MyApp(),
  // ));*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreenWidget(),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong(error: snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
          // return IsAllowedScreen(user: '');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Loading",
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  final String error;

  SomethingWentWrong({this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Error $error",
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
